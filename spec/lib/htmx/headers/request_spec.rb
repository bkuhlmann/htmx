# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Headers::Request do
  subject(:request) { described_class.new }

  describe ".for" do
    it "answers all supported headers" do
      request = described_class.for "HTTP_HX_BOOSTED" => "true",
                                    "HTTP_HX_CURRENT_URL" => "/test",
                                    "HTTP_HX_HISTORY_RESTORE_REQUEST" => "false",
                                    "HTTP_HX_PROMPT" => "Yes",
                                    "HTTP_HX_REQUEST" => "true",
                                    "HTTP_HX_TARGET" => "test",
                                    "HTTP_HX_TRIGGER_NAME" => "save",
                                    "HTTP_HX_TRIGGER" => "test"
      expect(request).to eq(
        described_class[
          boosted: "true",
          current_url: "/test",
          history_restore_request: "false",
          prompt: "Yes",
          request: "true",
          target: "test",
          trigger_name: "save",
          trigger: "test"
        ]
      )
    end

    it "ignores unsupported headers" do
      response = described_class.for "HTTP_HX_BOOSTED" => "true",
                                     "HTTP_HX_BAD" => "danger",
                                     "other" => "else"
      expect(response).to eq(described_class[boosted: "true"])
    end
  end

  describe ".key_for" do
    it "answers key for header" do
      expect(described_class.key_for("HTTP_HX_TRIGGER")).to eq(:trigger)
    end

    it "fails with invalid key" do
      expectation = proc { described_class.key_for "BOGUS" }
      expect(&expectation).to raise_error(KeyError, /BOGUS/)
    end
  end

  describe ".header_for" do
    it "answers header for key" do
      expect(described_class.header_for(:trigger)).to eq("HTTP_HX_TRIGGER")
    end

    it "fails with invalid key" do
      expectation = proc { described_class.key_for :bogus }
      expect(&expectation).to raise_error(KeyError, /:bogus/)
    end
  end

  describe "#initialize" do
    it "answers default attributes" do
      expect(request).to eq(
        described_class[
          boosted: nil,
          current_url: nil,
          history_restore_request: nil,
          prompt: nil,
          request: nil,
          target: nil,
          trigger_name: nil,
          trigger: nil
        ]
      )
    end
  end
end
