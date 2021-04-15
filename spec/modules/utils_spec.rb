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
    it "is expected to append 'hundred' " do
      expect(TestIncluder.hundreds_str(1)).to eq "one hundred"
    end

    it "is expected to append 'hundred and ' " do
      expect(TestIncluder.hundreds_str(3, true)).to eq "three hundred and "
    end
  end
end
