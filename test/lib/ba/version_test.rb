require_relative '../../test_helper'

describe Ba do
  it "must be defined" do
    Ba::VERSION.wont_be_nil
  end
end
