# frozen_string_literal: true
require 'active_record'

module Model
  # User
  class User < ActiveRecord::Base
    has_many :messages

    validates :external_id, presence: true, uniqueness: true
    validates :name, presence: true
  end
end
