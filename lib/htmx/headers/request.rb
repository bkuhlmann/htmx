# frozen_string_literal: true

module HTMX
  module Headers
    REQUEST_KEY_MAP = {
      "HX-Boosted" => :boosted,
      "HX-Current-URL" => :current_url,
      "HX-History-Restore-Request" => :history_restore_request,
      "HX-Prompt" => :prompt,
      "HX-Request" => :request,
      "HX-Target" => :target,
      "HX-Trigger-Name" => :trigger_name,
      "HX-Trigger" => :trigger
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
