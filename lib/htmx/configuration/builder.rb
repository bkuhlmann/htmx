# frozen_string_literal: true

require "refinements/hash"

module HTMX
  module Configuration
    # Builds configuration in HCON format.
    class Builder
      ALLOWED_CHARACTERS = /\A[0-9a-zA-Z.]*\Z/
      DELIMITERS = {array: ",", hash: ":"}.freeze

      using Refinements::Hash

      def initialize allowed_characters: ALLOWED_CHARACTERS, delimiters: DELIMITERS
        @allowed_characters = allowed_characters
        @delimiters = delimiters
      end

      def call **attributes
        attributes.map { |key, value| format_with key, value }
                  .join " "
      end

      private

      attr_reader :allowed_characters, :delimiters

      def format_with key, value
        case value
          when Array then "#{key}#{hash_delimiter}#{dump value.join(array_delimiter)}"
          when Hash
            value.flatten_keys!(prefix: key, delimiter: ".")
                 .map { |key, value| format_with key, value }
          when nil then key.to_s
          else "#{key}#{hash_delimiter}#{dump value.to_s}"
        end
      end

      def dump(value) = value.match?(allowed_characters) ? value : value.dump

      def array_delimiter
        @array_delimiter ||= delimiters.fetch :array
      end

      def hash_delimiter
        @hash_delimiter ||= delimiters.fetch :hash
      end
    end
  end
end
