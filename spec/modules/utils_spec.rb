# frozen_string_literal: true

RSpec.describe Nr2w::Utils do
  module TestIncluder
    class << self
      include Nr2w::Utils
    end
  end

  describe "#dozens_str" do
    it "is expected to translate 1 to 99" do
      tested_translate = []
        99.times do |idx|
        tested_translate << TestIncluder.dozens_str(idx + 1)
      end
      expected_translate =
        File.readlines('spec/support/one_to_ninetynine.txt').map{ |word| word.chomp }

      expect(tested_translate).to eq expected_translate
    end
  end

  describe "#hundreds_str" do
    it "is expected to append 'hundred'" do
      expect(TestIncluder.hundreds_str(1)).to eq "one hundred"
    end

    it "is expected to append 'hundred and '" do
      expect(TestIncluder.hundreds_str(3, true)).to eq "three hundred and "
    end
  end

  describe "#assemble_str" do
    it "is expected to include commas when have any THOUSAND WORD, except in the last position" do
      expect(TestIncluder.assemble_str("five hundred and fifty seven thousand one"))
        .to eq "five hundred and fifty seven thousand, one"
    end

    it "is expected to not include commas when have THOUSAND WORD in the last position" do
      expect(TestIncluder.assemble_str("five hundred and fifty seven thousand"))
        .to eq "five hundred and fifty seven thousand"
    end

    it "is expected to not include commas when don't have THOUSAND WORD" do
      expect(TestIncluder.assemble_str("five hundred and fifty seven"))
        .to eq "five hundred and fifty seven"
    end
  end

  describe "#deal_with_errors" do
    it "is expected to raise a error when input is not a integer" do
      expect{ TestIncluder.deal_with_errors("not integer") }
        .to raise_error(RuntimeError, "Not an integer")
    end

    it "is expected to raise a error when input is bigger then 2**100" do
      expect{ TestIncluder.deal_with_errors(2**100) }
        .to raise_error(RuntimeError, "Overflow")
    end
  end
end
