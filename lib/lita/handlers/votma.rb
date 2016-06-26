# frozen_string_literal: true
require 'uri'
require 'digest'
require 'model/link'
require 'model/user'
require 'model/channel'
require 'model/message'
require 'util/message_builder'
require 'util/url_helper'
require 'util/votma_database'

module Lita
  module Handlers
    # Votma
    class Votma < Handler
      config :votma_once_msg,
             type: String,
             default: '@%{sender} Vótmá! This has already been posted by '\
             '%{first_poster} at %{first_posted_at} in channel '\
             '%{first_posted_in_channel}. Shame on you. %{sender}--'
      config :votma_manytimes_msg,
             type: String,
             default: '@%{sender} Vótmá! This has already been posted '\
             '%{times_posted} times, first time by %{first_poster} at '\
             '%{first_posted_at} in channel %{first_posted_in_channel}, last '\
             'time by %{last_poster} at %{last_posted_at} in channel '\
             '%{last_posted_in_channel}. Shame on you. %{sender}--'
      on :unhandled_message, :process_message

      def initialize(*args)
        super(*args)
        @url_helper ||= ::Util::UrlHelper.instance
        @database ||= ::Util::VotmaDatabase.instance
      end

      def process_message(payload)
        chat_message = payload[:message]
        uris = URI.extract(chat_message.body, /http(s)?/)
        return unless uris.any?
        message = @database.save_message(chat_message)
        uris.uniq.each do |uri|
          id = @url_helper.url_id(uri)
          url_id_hash = Digest::SHA256.hexdigest(id)
          same_urls = Model::Link.where(url_id_hash: url_id_hash)
                                 .order(:created_at)
          ::Util::MessageBuilder.votma_message(
            same_urls, chat_message, config, robot
          )
          @database.save_link(uri, message)
        end
      end

      Lita.register_handler(self)
    end
  end
end
