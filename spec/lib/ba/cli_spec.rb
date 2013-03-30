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

  describe "#install" do
    context "when the config file exists" do
      before do
        File.stub(:open){ true }
      end

      it "doesn't create a new file" do
        STDOUT.should_receive(:puts).with "configuration file already exists"
        subject.install
      end
    end

    context "when the config file doesn't exist" do
      let(:config_path){ "config" }
      let(:home_path){ "~/config" }

      before do
        File.stub(:open){ raise Errno::ENOENT }
        File.stub(:join){ config_path }
      end

      it "creates the new path" do
        subject.should_receive(:system).with "mkdir #{home_path}"
        subject.should_receive(:system).with "cp #{config_path}/config.sample.yml #{home_path}/config.yml"
        STDOUT.should_receive(:puts).with "[INFO] A config folder will be created in your home path '~/config'\n\n"\
          "[INFO] Please edit your ~/config/config.yml"
        subject.install
      end
    end
  end

  describe "#version" do
    it "returns the current application version" do
      STDOUT.should_receive(:puts).with ("0.0.6")
      subject.version
    end
  end
end
