# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX do
  describe ".[]" do
    it "answers prefixed attributes" do
      attributes = described_class["get" => "/tasks", trigger: "click"]
      expect(attributes).to eq("hx-get" => "/tasks", "hx-trigger" => "click")
    end

    it "answers empty hash with no arguments" do
      expect(described_class[]).to eq({})
    end
  end
end
