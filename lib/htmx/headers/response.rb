# frozen_string_literal: true

module HTMX
  module Headers
    RESPONSE_KEY_MAP = {
      "HX-Location" => :location,
      "HX-Push-Url" => :push_url,
      "HX-Redirect" => :redirect,
      "HX-Refresh" => :refresh,
      "HX-Replace-Url" => :replace_url,
      "HX-Reswap" => :reswap,
      "HX-Retarget" => :retarget,
      "HX-Trigger" => :trigger,
      "HX-Trigger-After-Settle" => :trigger_after_settle,
      "HX-Trigger-After-Swap" => :trigger_after_swap
    }.freeze

    # Models the supported HTMX response headers.
    Response = Data.define(
      :location,
      :push_url,
      :redirect,
      :refresh,
      :replace_url,
      :reswap,
      :retarget,
      :trigger,
      :trigger_after_settle,
      :trigger_after_swap
    ) do
      def self.for(key_map: RESPONSE_KEY_MAP, **attributes)
        new(**attributes.slice(*key_map.keys).transform_keys!(key_map))
      end

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
    end
  end
end
