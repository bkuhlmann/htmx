# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.new.then do |loader|
  loader.inflector.inflect "htmx" => "HTMX"
  loader.tag = File.basename __FILE__, ".rb"
  loader.push_dir __dir__
  loader.setup
end

# Main namespace.
module HTMX
  def self.loader(registry = Zeitwerk::Registry) = registry.loader_for __FILE__

  def self.[](...)
    @prefixer ||= Prefixer.new
    @prefixer.call(...)
  end
end
