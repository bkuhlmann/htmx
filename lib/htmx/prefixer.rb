# frozen_string_literal: true

require "refinements/arrays"

module HTMX
  # Prefixes HTML element attributes for proper consumption by the HTMX JavaScript library.
  class Prefixer
    using Refinements::Arrays

    ALLOWED = %w[hx data-hx].freeze

    def initialize default = "hx", allowed: ALLOWED
      @default = default
      @allowed = allowed
      validate
    end

    def call(**attributes) = attributes.transform_keys! { |key| "#{default}-#{key}" }

    private

    attr_reader :default, :allowed

    def validate
      return true if allowed.include? default

      fail Error, %(Invalid prefix: #{default.inspect}. Use: #{allowed.to_usage "or"}.)
    end
  end
end
