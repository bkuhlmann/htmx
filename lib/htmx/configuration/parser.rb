# frozen_string_literal: true

require "json"
require "refinements/string"

module HTMX
  module Configuration
    # Parses either HCON or JSON configuration into a Hash.
    class Parser
      DELIMITERS = {array: ",", hash: ":", pair: /\s+|,\s*/}.freeze

      using Refinements::String

      def initialize delimiters: DELIMITERS
        @delimiters = delimiters
      end

      def call text
        String(text).split(pair_delimiter).each.with_object({}) do |pair, attributes|
          key, value = pair.split hash_delimiter
          attributes[key] = parse value
        end
      end

      private

      attr_reader :delimiters

      # :reek:UtilityFunction
      def parse object
        case object
          when /\A\d+\z/ then object.to_i
          when /\A\d+\.??\d+\z/ then object.to_f
          when "true" then true
          when "false" then false
          else object
        end
      end

      def array_delimiter
        @array_delimiter ||= delimiters.fetch :array
      end

      def hash_delimiter
        @hash_delimiter ||= delimiters.fetch :hash
      end

      def pair_delimiter
        @pair_delimiter ||= delimiters.fetch :pair
      end
    end
  end
end
