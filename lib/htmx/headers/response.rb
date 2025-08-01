# frozen_string_literal: true

module HTMX
  module Headers
    # Models the supported HTMX response headers.
    Response = Data.define(*RESPONSE_MAP.keys) do
      def self.for(key_map: RESPONSE_MAP.invert, **attributes)
        new(**attributes.slice(*key_map.keys).transform_keys!(key_map))
      end

      def self.key_for(header, key_map: RESPONSE_MAP.invert) = key_map.fetch header

      def self.header_for(key, key_map: RESPONSE_MAP) = key_map.fetch key

      def initialize location: nil,
                     push_url: nil,
                     redirect: nil,
                     refresh: nil,
                     replace_url: nil,
                     reswap: nil,
                     retarget: nil,
                     trigger: nil,
                     trigger_after_settle: nil,
                     trigger_after_swap: nil
        super
      end

      def refresh? = refresh == "true"
    end
  end
end
