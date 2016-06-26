# frozen_string_literal: true
require 'active_support'
require 'addressable'
require 'singleton'

module Util
  # UrlHelper
  class UrlHelper
    include Singleton

    ALLOWED_RULES = %w(query-param split-path).freeze

    def initialize
      unless @rules
        votma_config_dir = File.expand_path('../../../config', __FILE__)
        rules_path = File.join(votma_config_dir, 'url_rules.yml')
        @rules = YAML.load_file(rules_path)
        @rules.map!(&:deep_symbolize_keys!)
        validate_rules
      end
    end

    def domain_of(url)
      url = "http://#{url}" unless url =~ %r{^http(s)?:\/\/}
      domain = URI.parse(url).host
      domain.sub!(/\Awww./, '')
      domain.sub!(/\Am./, '')
      domain
    end

    def url_id(url)
      result = nil
      @rules.each do |rule|
        next unless rule[:match] =~ url
        uri = Addressable::URI.parse(url)
        case rule[:rule]
        when 'query-param'
          params = { id: uri.query_values[rule[:subject]] }
          result = rule[:format] % params
        when 'split-path'
          params = { id: uri.path.split('/')[rule[:subject]] }
          result = rule[:format] % params
        end
      end
      result = clean_url(url) if result.nil? || result.empty?
      result
    end

    private

    def validate_rules # rubocop:disable Metrics/CyclomaticComplexity
      @rules.reject! do |rule|
        invalid = false
        unless rule[:match].instance_of? Regexp
          puts "Dropping rule: #{rule[:match]}. Match must be a regexp."
          invalid = true
        end
        if rule[:format].blank?
          puts "Dropping rule: #{rule[:match]}. No format specified."
          invalid = true
        end
        if rule[:rule].blank?
          puts "Dropping rule: #{rule[:match]}. No rule specified."
          invalid = true
        end
        unless ALLOWED_RULES.include? rule[:rule]
          puts "Dropping rule: #{rule[:match]}. Invalid rule."
          invalid = true
        end
        if (%w(query-param split-path).include? rule[:rule]) &&
           rule[:subject].blank?
          puts "Dropping rule: #{rule[:match]}. Rule requires a subject."
          invalid = true
        end
        invalid
      end
    end

    def clean_url(url)
      # Remove request parameters
      result = url[/[^\?]+/]
      # Remove protocol
      result = result.split('://', 2).last
      # Remove trailing slash
      result.chomp('/')
    end
  end
end
