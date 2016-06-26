# frozen_string_literal: true
require 'active_record'

module Model
  # Link
  class Link < ActiveRecord::Base
    belongs_to :message

    validates :url, presence: true
    validates :url_hash, presence: true, length: { is: 64 }
    validates :url_id, presence: true
    validates :url_id_hash, presence: true, length: { is: 64 }
    validates :domain, presence: true
    validates :domain_hash, presence: true, length: { is: 64 }
  end
end
