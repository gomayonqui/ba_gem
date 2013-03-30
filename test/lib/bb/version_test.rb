require_relative '../../test_helper'

describe Bb do
  it "must be defined" do
    Bb::VERSION.wont_be_nil
  end
end
