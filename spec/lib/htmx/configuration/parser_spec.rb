# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Configuration::Parser do
  subject(:parser) { described_class.new }

  describe "#call" do
    it "answers configuration" do
      expect(parser.call("")).to eq("")
    end
  end
end
