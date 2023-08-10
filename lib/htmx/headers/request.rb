# frozen_string_literal: true

module HTMX
  module Headers
    REQUEST_KEY_MAP = {
      "HTTP_HX_BOOSTED" => :boosted,
      "HTTP_HX_CURRENT_URL" => :current_url,
      "HTTP_HX_HISTORY_RESTORE_REQUEST" => :history_restore_request,
      "HTTP_HX_PROMPT" => :prompt,
      "HTTP_HX_REQUEST" => :request,
      "HTTP_HX_TARGET" => :target,
      "HTTP_HX_TRIGGER_NAME" => :trigger_name,
      "HTTP_HX_TRIGGER" => :trigger
    }.freeze

    # Models the supported HTMX request headers.
    Request = Data.define(
      :boosted,
      :current_url,
      :history_restore_request,
      :prompt,
      :request,
      :target,
      :trigger_name,
      :trigger
    ) do
      def self.for(key_map: REQUEST_KEY_MAP, **attributes)
        new(**attributes.slice(*key_map.keys).transform_keys!(key_map))
      end

      def self.key_for(header, key_map: REQUEST_KEY_MAP) = key_map.fetch header

      def self.header_for(key, key_map: REQUEST_KEY_MAP.invert) = key_map.fetch key

      def initialize boosted: nil,
                     current_url: nil,
                     history_restore_request: nil,
                     prompt: nil,
                     request: nil,
                     target: nil,
                     trigger_name: nil,
                     trigger: nil
        super
      end
    end
  end
end
