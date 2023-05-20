# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Prefixer do
  subject(:prefixer) { described_class.new }

  describe "#initialize" do
    it "allows default prefix" do
      expectation = proc { described_class.new }
      expect(&expectation).not_to raise_error
    end

    it %(allows "hx" prefix) do
      expectation = proc { described_class.new "hx" }
      expect(&expectation).not_to raise_error
    end

    it %(allows "data-hx" prefix) do
      expectation = proc { described_class.new "data-hx" }
      expect(&expectation).not_to raise_error
    end

    it "fails with invalid prefix" do
      expectation = proc { described_class.new "danger" }

      expect(&expectation).to raise_error(
        HTMX::Error,
        %(Invalid prefix: "danger". Use: "hx" or "data-hx".)
      )
    end
  end

  describe "#call" do
    it "answers prefixed attributes" do
      attributes = prefixer.call "get" => "/tasks", trigger: "click"
      expect(attributes).to eq("hx-get" => "/tasks", "hx-trigger" => "click")
    end

    it "answers empty hash with no arguments" do
      expect(prefixer.call).to eq({})
    end
  end
end
