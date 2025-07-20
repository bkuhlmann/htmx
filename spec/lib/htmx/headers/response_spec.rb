# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Headers::Response do
  subject(:response) { described_class.new }

  describe ".for" do
    it "answers all supported headers" do
      response = described_class.for "HX-Location" => "/",
                                     "HX-Push-Url" => "/test",
                                     "HX-Redirect" => "/test",
                                     "HX-Refresh" => "true",
                                     "HX-Replace-Url" => "/test",
                                     "HX-Reswap" => "none",
                                     "HX-Retarget" => ".test",
                                     "HX-Trigger" => "test",
                                     "HX-Trigger-After-Settle" => "test",
                                     "HX-Trigger-After-Swap" => "test"

      expect(response).to eq(
        described_class[
          location: "/",
          push_url: "/test",
          redirect: "/test",
          refresh: "true",
          replace_url: "/test",
          reswap: "none",
          retarget: ".test",
          trigger: "test",
          trigger_after_settle: "test",
          trigger_after_swap: "test"
        ]
      )
    end

    it "ignores unsupported headers" do
      response = described_class.for "HX-Location" => "/", "HX-Bad" => "danger", "other" => "else"
      expect(response).to eq(described_class[location: "/"])
    end
  end

  describe ".key_for" do
    it "answers key for header" do
      expect(described_class.key_for("HX-Redirect")).to eq(:redirect)
    end

    it "fails with invalid key" do
      expectation = proc { described_class.key_for "Bogus" }
      expect(&expectation).to raise_error(KeyError, /Bogus/)
    end
  end

  describe ".header_for" do
    it "answers header for key" do
      expect(described_class.header_for(:redirect)).to eq("HX-Redirect")
    end

    it "fails with invalid key" do
      expectation = proc { described_class.key_for :bogus }
      expect(&expectation).to raise_error(KeyError, /:bogus/)
    end
  end

  describe "#initialize" do
    it "answers default attributes" do
      expect(response).to eq(
        described_class[
          location: nil,
          push_url: nil,
          redirect: nil,
          refresh: nil,
          replace_url: nil,
          reswap: nil,
          retarget: nil,
          trigger: nil,
          trigger_after_settle: nil,
          trigger_after_swap: nil
        ]
      )
    end
  end

  describe "#refresh?" do
    it "answers true when enabled" do
      expect(described_class[refresh: "true"].refresh?).to be(true)
    end

    it "answers false when disabled" do
      expect(response.refresh?).to be(false)
    end
  end
end
