require 'spec_helper'

describe Ba do
  describe "#version" do
    it "includes a version" do
      Ba::VERSION.should_not be_nil
    end
  end
end
