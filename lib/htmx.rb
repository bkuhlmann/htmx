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
    prompt: "HTTP_HX_PROMPT",
    request: "HTTP_HX_REQUEST",
    target: "HTTP_HX_TARGET",
    trigger_name: "HTTP_HX_TRIGGER_NAME",
    trigger: "HTTP_HX_TRIGGER"
  }.freeze

  RESPONSE_MAP = {
    location: "HX-Location",
    push_url: "HX-Push-Url",
    redirect: "HX-Redirect",
    refresh: "HX-Refresh",
    replace_url: "HX-Replace-Url",
    reswap: "HX-Reswap",
    retarget: "HX-Retarget",
    trigger: "HX-Trigger",
    trigger_after_settle: "HX-Trigger-After-Settle",
    trigger_after_swap: "HX-Trigger-After-Swap"
  }.freeze

  def self.loader registry = Zeitwerk::Registry
    @loader ||= registry.loaders.each.find { |loader| loader.tag == File.basename(__FILE__, ".rb") }
  end

  def self.[](...)
    @prefixer ||= Prefixer.new
    @prefixer.call(...)
  end
end
