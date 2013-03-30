require 'spec_helper'

describe Bb do
  describe "#version" do
    it "includes a version" do
      Bb::VERSION.should_not be_nil
    end
  end
end
