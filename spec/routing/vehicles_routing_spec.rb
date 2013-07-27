require "spec_helper"

describe VehiclesController do
  describe "routing" do

    it "routes to #index" do
      get("/vehicles").should route_to("vehicles#index")
    end

    it "routes to #create" do
      post("/vehicles").should route_to("vehicles#create")
    end

    it "routes to #makes" do
      get("/vehicles/makes").should route_to("vehicles#makes")
    end

  end
end
