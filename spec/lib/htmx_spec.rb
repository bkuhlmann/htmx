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

  describe ".request!" do
    it "mutates request headers" do
      headers = {}
      described_class.request! headers, boosted: true, prompt: "Yes"

      expect(headers).to eq("HTTP_HX_BOOSTED" => true, "HTTP_HX_PROMPT" => "Yes")
    end

    it "mutates request headers by passing unknown keys through" do
      headers = {}
      described_class.request! headers, bogus: true

      expect(headers).to eq(bogus: true)
    end

    it "answers empty hash when there is nothing to mutate" do
      expect(described_class.request!({})).to eq({})
    end
  end

  describe ".request?" do
    let(:headers) { {"HTTP_HX_CURRENT_URL" => "/test"} }

    it "answers true when value matches" do
      expect(described_class.request?(headers, :current_url, "/test")).to be(true)
    end

    it "answers false when value doesn't match" do
      expect(described_class.request?(headers,  :current_url, "/other")).to be(false)
    end
  end

  describe ".response" do
    it "answers response header data" do
      result = described_class.response "HX-Redirect" => "/test", "HX-Reswap" => "none"
      expect(result).to eq(HTMX::Headers::Response[redirect: "/test", reswap: "none"])
    end
  end

  describe ".response!" do
    it "mutates response headers" do
      headers = {}
      described_class.response! headers, location: "/", push_url: "/test"

      expect(headers).to eq("HX-Location" => "/", "HX-Push-Url" => "/test")
    end

    it "mutates response headers by passing unknown keys through" do
      headers = {}
      described_class.response! headers, bogus: true

      expect(headers).to eq(bogus: true)
    end

    it "answers empty hash when there is nothing to mutate" do
      expect(described_class.response!({})).to eq({})
    end
  end

  describe ".response?" do
    let(:headers) { {"HX-Push-Url" => "/test"} }

    it "answers true when value matches" do
      expect(described_class.response?(headers, :push_url, "/test")).to be(true)
    end

    it "answers false when value doesn't match" do
      expect(described_class.response?(headers, :push_url, "/other")).to be(false)
    end
  end
end
