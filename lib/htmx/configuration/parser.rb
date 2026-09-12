# frozen_string_literal: true

require "json"

module HTMX
  module Configuration
    # Parses either HCON or JSON configuration into a Hash.
    class Parser
      DELIMITERS = {array: ",", hash: ":"}.freeze

      def initialize delimiters: DELIMITERS
        @delimiters = delimiters
      end

      def call text
        text
      end

      private

      attr_reader :delimiters
    end
  end
end
