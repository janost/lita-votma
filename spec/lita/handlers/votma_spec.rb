# frozen_string_literal: true
require 'spec_helper'

describe Lita::Handlers::Votma, lita_handler: true do
  it { is_expected.to route('some message').to(:process_message) }
end
