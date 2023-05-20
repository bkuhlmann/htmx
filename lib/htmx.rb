# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.for_gem.then do |loader|
  loader.inflector.inflect "htmx" => "HTMX"
  loader.setup
end

# Main namespace.
module HTMX
  def self.[](...) = Prefixer.new.call(...)
end
