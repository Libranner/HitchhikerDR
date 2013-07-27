require 'spec_helper'

describe AuthenticationsController, "OmniAuth" do
  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "sets a session variable to the OmniAuth auth hash - Facebook" do
    request.env["omniauth.auth"]['uid'].should == '1234'
  end


end