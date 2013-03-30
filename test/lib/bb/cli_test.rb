require_relative '../../test_helper'

describe Bb::CLI do
  describe "when Bancolombia bank in the bank.yml file" do
    it "respond to bancolombia" do
      assert_respond_to Bb::CLI.new, "bancolombia"
    end
  end

  describe "when Payoneer bank is in the bank.yml file" do
    it "respond to payoneer" do
      assert_respond_to Bb::CLI.new, "payoneer"
    end
  end
end
