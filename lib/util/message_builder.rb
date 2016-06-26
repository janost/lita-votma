# frozen_string_literal: true

module Util
  # MessageBuilder
  class MessageBuilder
    def self.votma_message(same_urls, chat_message, config, robot)
      return if same_urls.nil? || same_urls.empty?
      message_parameters = message_params(same_urls)
      message_parameters[:sender] = user_mention_name(
        chat_message.source.user
      )
      if same_urls.count > 1
        robot.send_message(chat_message.source,
                           config.votma_manytimes_msg % message_parameters)
      else
        robot.send_message(chat_message.source,
                           config.votma_once_msg % message_parameters)
      end
    end

    def self.user_mention_name(user_object)
      if user_object.metadata['mention_name']
        user_object.metadata['mention_name']
      else
        user_object.id
      end
    end

    def self.message_params(same_urls)
      first_post = same_urls.first
      last_post = same_urls.last
      {
        first_poster: "@#{first_post.message.user.mention_name}",
        first_posted_at: first_post.created_at.localtime,
        first_posted_in_channel: "\##{first_post.message.channel.name}",
        last_poster: "@#{last_post.message.user.mention_name}",
        last_posted_at: last_post.created_at.localtime,
        last_posted_in_channel: "\##{last_post.message.channel.name}",
        times_posted: same_urls.count
      }
    end

    private_class_method :message_params
  end
end
