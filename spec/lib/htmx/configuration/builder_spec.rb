# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Configuration::Builder do
  subject(:builder) { described_class.new }

  describe "#call" do
    it "answers single attribute" do
      expect(builder.call(test: :example)).to eq("test:example")
    end

    it "answers multiple attributes" do
      expect(builder.call(one: 1, two: :two, three: "three")).to eq("one:1 two:two three:three")
    end

    it "answers formatted array value" do
      expect(builder.call(test: %w[one two three])).to eq("test:'one,two,three'")
    end

    it "answers formatted hash value" do
      expect(builder.call(test: {one: 1, two: 2})).to eq("test.one:1 test.two:2")
    end

    it "answers formatted nested hash value" do
      result = builder.call test: {one: 1, two: {three: 3, four: 4}}
      expect(result).to eq("test.one:1 test.two.three:3 test.two.four:4")
    end

    it "answers unit value" do
      expect(builder.call(test: "100s")).to eq("test:100s")
    end

    it "answers quoted value (space)" do
      expect(builder.call(test: "first last")).to eq("test:'first last'")
    end

    it "answers quoted value (special characters)" do
      expect(builder.call(test: "e&-ample!")).to eq("test:'e&-ample!'")
    end

    it "answers boolean values" do
      expect(builder.call(one: true, two: false)).to eq("one:true two:false")
    end

    it "answers only keys when values are nil" do
      expect(builder.call(one: nil, two: nil)).to eq("one two")
    end

    it "answers empty string with no arguments" do
      expect(builder.call).to eq("")
    end
  end
end
