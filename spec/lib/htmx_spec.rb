# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX do
  describe ".loader" do
    it "eager loads" do
      expectation = proc { described_class.loader.eager_load force: true }
      expect(&expectation).not_to raise_error
    end

    it "answers unique tag" do
      expect(described_class.loader.tag).to eq("htmx")
    end
  end

  describe ".[]" do
    it "answers prefixed attributes" do
      attributes = described_class["get" => "/tasks", trigger: "click"]
      expect(attributes).to eq("hx-get" => "/tasks", "hx-trigger" => "click")
    end

    it "answers empty hash with no arguments" do
      expect(described_class[]).to eq({})
    end
  end

  describe ".request" do
    it "answers request header data" do
      result = described_class.request "HTTP_HX_BOOSTED" => "true", "HTTP_HX_PROMPT" => "Yes"
      expect(result).to eq(HTMX::Headers::Request[boosted: "true", prompt: "Yes"])
    end
  end

  describe ".response" do
    it "answers response header data" do
      result = described_class.response "HX-Redirect" => "/test", "HX-Reswap" => "none"
      expect(result).to eq(HTMX::Headers::Response[redirect: "/test", reswap: "none"])
    end
  end
end
