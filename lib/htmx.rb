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
  def self.loader registry = Zeitwerk::Registry
    @loader ||= registry.loaders.each.find { |loader| loader.tag == File.basename(__FILE__, ".rb") }
  end

  def self.[](...)
    @prefixer ||= Prefixer.new
    @prefixer.call(...)
  end
end
