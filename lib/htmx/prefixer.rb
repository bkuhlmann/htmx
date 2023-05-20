# frozen_string_literal: true

require "refinements/arrays"

module HTMX
  # Prefixes HTML element attributes for proper consumption by HTMX JavaScript library.
  class Prefixer
    using Refinements::Arrays

    PREFIXES = %w[hx data-hx].freeze

    def initialize default = "hx", allowed: PREFIXES
      @default = default
      @allowed = allowed
      validate
    end

    def call(**attributes) = attributes.transform_keys! { |key| "#{default}-#{key}" }

    private

    attr_reader :default, :allowed

    def validate
      return true if allowed.include? default

      usage = allowed.map(&:inspect).to_sentence conjunction: "or"

      fail Error, "Invalid prefix: #{default.inspect}. Use: #{usage}."
    end
  end
end
