# frozen_string_literal: true

require "refinements/string"

module HTMX
  module Headers
    # Models the supported HTMX request headers.
    Request = Data.define(*REQUEST_MAP.keys) do
      using Refinements::String

      def self.for key_map: REQUEST_MAP.invert, **attributes
        new(**attributes.slice(*key_map.keys).transform_keys!(key_map))
      end

      def self.key_for(header, key_map: REQUEST_MAP.invert) = key_map.fetch header

      def self.header_for(key, key_map: REQUEST_MAP) = key_map.fetch key

      def initialize boosted: nil,
                     current_url: nil,
                     history_restore_request: nil,
                     request: nil,
                     request_type: nil,
                     source: nil,
                     target: nil
        super
      end

      def boosted? = boosted == "true"

      def history_restore_request? = history_restore_request == "true"

      def request? = request == "true"
    end
  end
end
