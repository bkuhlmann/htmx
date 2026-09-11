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
  REQUEST_MAP = {
    boosted: "HTTP_HX_BOOSTED",
    current_url: "HTTP_HX_CURRENT_URL",
    history_restore_request: "HTTP_HX_HISTORY_RESTORE_REQUEST",
    request: "HTTP_HX_REQUEST",
    request_type: "HTTP_HX_REQUEST_TYPE",
    source: "HTTP_HX_SOURCE",
    target: "HTTP_HX_TARGET"
  }.freeze

  RESPONSE_MAP = {
    location: "HX-Location",
    push_url: "HX-Push-Url",
    redirect: "HX-Redirect",
    refresh: "HX-Refresh",
    replace_url: "HX-Replace-Url",
    reselect: "HX-Reselect",
    reswap: "HX-Reswap",
    retarget: "HX-Retarget",
    trigger: "HX-Trigger"
  }.freeze

  def self.loader registry = Zeitwerk::Registry
    @loader ||= registry.loaders.each.find { |loader| loader.tag == File.basename(__FILE__, ".rb") }
  end

  def self.[](...)
    @prefixer ||= Prefixer.new
    @prefixer.call(...)
  end

  def self.request(**) = Headers::Request.for(**)

  def self.request!(headers, **attributes) = headers.merge! attributes.transform_keys!(REQUEST_MAP)

  def self.request?(headers, key, value) = headers[REQUEST_MAP[key]] == value

  def self.response(**) = Headers::Response.for(**)

  def self.response! headers, **attributes
    headers.merge! attributes.transform_keys!(RESPONSE_MAP)
  end

  def self.response?(headers, key, value) = headers[RESPONSE_MAP[key]] == value
end
