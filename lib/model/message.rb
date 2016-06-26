# frozen_string_literal: true
require 'active_record'

module Model
  # Message
  class Message < ActiveRecord::Base
    belongs_to :user
    belongs_to :channel
    has_many :links

    validates :body, presence: true
    validates :body_hash, presence: true, length: { is: 64 }
  end
end
