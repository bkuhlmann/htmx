# frozen_string_literal: true

require "spec_helper"

RSpec.describe HTMX::Configuration::Parser do
  subject(:parser) { described_class.new }

  # TODO: key/values can be seperated by spaces or commas.

  describe "#call" do
    it "answers hash for single attribute" do
      expect(parser.call("one:1")).to eq("one" => 1)
    end

    it "answers hash for multiple attributes split by single spaces" do
      expect(parser.call("one:1 two:2 three:3")).to eq("one" => 1, "two" => 2, "three" => 3)
    end

    it "answers hash for multiple attributes split by multiple spaces" do
      expect(parser.call("one:1 two:2   three:3")).to eq("one" => 1, "two" => 2, "three" => 3)
    end

    it "answers hash for multiple attributes split by commas" do
      expect(parser.call("one:1,two:2,three:3")).to eq("one" => 1, "two" => 2, "three" => 3)
    end

    it "answers hash for multiple attributes split by new lines" do
      configuration = <<~CONTENT
        one:1
        two:2
        three:3
      CONTENT

      expect(parser.call(configuration)).to eq("one" => 1, "two" => 2, "three" => 3)
    end

    it "answers hash for multiple attributes split by commas and optional spaces" do
      expect(parser.call("one:1, two:2,  three:3")).to eq("one" => 1, "two" => 2, "three" => 3)
    end

    it "answers hash with nil values for keys only" do
      expect(parser.call("one two three")).to eq("one" => nil, "two" => nil, "three" => nil)
    end

    it "answers hash with dot notation for keys" do
      expect(parser.call("a:1 a.b:2 a.b.c:3")).to eq("a" => 1, "a.b" => 2, "a.b.c" => 3)
    end

    it "answers hash with quoted dot notation for keys" do
      expect(parser.call("'a':1 'a.b':2 'a.b.c':3")).to eq("'a'" => 1, "'a.b'" => 2, "'a.b.c'" => 3)
    end

    it "answers hash with integer value" do
      expect(parser.call("test:1")).to eq("test" => 1)
    end

    it "answers hash with float value" do
      expect(parser.call("test:1.5")).to eq("test" => 1.5)
    end

    it "answers hash with array value" do
      pending "Needs implementation."
      expect(parser.call("test:'one,two,three'")).to eq("one" => %w[one two three])
    end

    it "answers hash with unit value" do
      expect(parser.call("test:100s")).to eq("test" => "100s")
    end

    it "answers hash with quoted value (space)" do
      pending "Implementation needs to use StringScaner."
      expect(parser.call("test:'first last'")).to eq("test" => "first last")
    end

    it "answers hash with quoted value (special characters)" do
      pending "Implementation needs to strip sinqle quotes, and handle spaces, colons, and commas."
      expect(parser.call("test:'e&-a,mp l:e!'")).to eq("test" => "e&-a,mp l:e!")
    end

    it "answers hash with boolean values" do
      expect(parser.call("one:true two:false")).to eq("one" => true, "two" => false)
    end

    it "answers empty hash for empty string" do
      expect(parser.call("")).to eq({})
    end

    it "answers empty hash for nil" do
      expect(parser.call(nil)).to eq({})
    end
  end
end
