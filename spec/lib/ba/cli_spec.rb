require 'spec_helper'

describe Ba::CLI do
  context "Including new scrapers" do
    context "when Bancolombia bank in the bank.yml file" do
      it "respond to bancolombia" do
        expect(subject).to respond_to "bancolombia"
      end
    end

    context "when Payoneer bank is in the bank.yml file" do
      it "respond to payoneer" do
        expect(subject).to respond_to "payoneer"
      end
    end
  end

  describe "#version" do
    it "returns the current application version" do
      STDOUT.should_receive(:puts).with ("0.0.11")
      subject.version
    end
  end
end
