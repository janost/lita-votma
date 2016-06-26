# frozen_string_literal: true

require 'active_record'
require 'digest'
require 'singleton'
require 'model/link'
require 'model/user'
require 'model/channel'
require 'model/message'
require 'util/message_builder'
require 'util/url_helper'

module Util
  # VotmaDatabase
  class VotmaDatabase
    include Singleton

    def initialize
      votma_config_dir = File.expand_path('../../../config', __FILE__)
      db_dir = File.expand_path('../../../db', __FILE__)
      db_config_path = File.read(File.join(votma_config_dir, 'database.yml'))
      db_config_yaml = ERB.new(db_config_path).result
      votma_db_configs = YAML.load(db_config_yaml) || {}
      ::ActiveRecord::Base.establish_connection(
        votma_db_configs[ENV['ENV'] || 'development']
      )
      ActiveRecord::Migrator.migrate("#{db_dir}/migrate")
      @url_helper ||= ::Util::UrlHelper.instance
    end

    def find_or_save_channel(room_object)
      channel = Model::Channel.find_by(
        external_id: room_object.id
      )
      if channel.nil?
        chat_room = Lita::Room.find_by_id(room_object.id)
        channel_name = chat_room.nil? ? room_object.name : chat_room.name
        channel = Model::Channel.create(
          external_id: room_object.id,
          name: channel_name
        )
      end
      channel
    end

    def find_or_save_user(user_object)
      user = Model::User.find_by(external_id: user_object.id)
      mention_name = ::Util::MessageBuilder.user_mention_name(user_object)
      if user.nil?
        user = Model::User.create(
          external_id: user_object.id,
          name: user_object.name,
          mention_name: mention_name
        )
      elsif user.name != user_object.name || user.mention_name != mention_name
        user.update(name: user_object.name, mention_name: mention_name)
      end
      user
    end

    def save_message(chat_message)
      user = find_or_save_user(chat_message.source.user)
      channel = find_or_save_channel(chat_message.source.room_object)
      Model::Message.create(
        body: chat_message.body,
        body_hash: Digest::SHA256.hexdigest(chat_message.body),
        user: user,
        channel: channel
      )
    end

    def save_link(url, message)
      url_id = @url_helper.url_id(url)
      domain = @url_helper.domain_of(url)
      url_hash = Digest::SHA256.hexdigest(url)
      url_id_hash = Digest::SHA256.hexdigest(url_id)
      domain_hash = Digest::SHA256.hexdigest(domain)
      Model::Link.create(
        url: url,
        url_hash: url_hash,
        url_id: url_id,
        url_id_hash: url_id_hash,
        domain: domain,
        domain_hash: domain_hash,
        message: message
      )
    end
  end
end
