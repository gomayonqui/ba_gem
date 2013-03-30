require 'spec_helper'

describe Bb::CLI do
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

  describe "#install" do
    context "when the config file exists" do
      before do
        File.stub(:open){ true }
      end

      it "doesn't create a new file" do
        subject.should_not_receive(:create_config_file_for_banks){ true }
      end
    end

    context "when the config file doesn't exist" do
      before do
        File.stub(:open){ raise Errno::ENOENT }
      end

      it "retuns the path" do
        subject.should_receive(:create_config_file_for_banks){ true }
        subject.install
      end
    end
  end
end
