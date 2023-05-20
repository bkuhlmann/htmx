# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Headers::Request do
  subject(:request) { described_class.new }

  describe ".for" do
    it "answers all supported headers" do
      request = described_class.for "HX-Boosted" => "true",
                                    "HX-Current-URL" => "/test",
                                    "HX-History-Restore-Request" => "false",
                                    "HX-Prompt" => "Yes",
                                    "HX-Request" => "true",
                                    "HX-Target" => "test",
                                    "HX-Trigger-Name" => "save",
                                    "HX-Trigger" => "test"
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
      response = described_class.for "HX-Boosted" => "true", "HX-Bad" => "danger", "other" => "else"
      expect(response).to eq(described_class[boosted: "true"])
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
