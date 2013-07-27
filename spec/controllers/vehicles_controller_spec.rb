require 'spec_helper'

describe VehiclesController do

  # This should return the minimal set of attributes required to create a valid
  # Vehicle. As you add validations to Vehicle, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "make" => "Honda", "model"=> "Civic", "year"=>2012 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VehiclesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all vehicles as @vehicles" do
      vehicle = Vehicle.create! valid_attributes
      get :index, {}, valid_session
      assigns(:vehicles).should eq([vehicle])
    end
  end

  describe "GET" do
    it "all makes" do
      FactoryGirl.create(:vehicle, make: "Audi", model: "A6", year: 2012)
      FactoryGirl.create(:vehicle, make: "Audi", model: "A4", year: 2012)
      FactoryGirl.create(:vehicle, make: "BMW", model: "Serie 6", year: 2012)
      get :makes, :format => :json
      response.status.should be(200)
      makes = JSON.parse(response.body)
      makes.size.should eql 2
    end

    it "all models" do
      FactoryGirl.create(:vehicle, make: "Audi", model: "A6", year: 2012)
      FactoryGirl.create(:vehicle, make: "Audi", model: "A4", year: 2012)
      get :models, :make=> 'Audi', :format => :json
      response.status.should be 200
      models = JSON.parse(response.body)
      models.size.should eql 2
    end

    it "year from make and model" do
      FactoryGirl.create(:vehicle, make: 'Audi', model: 'A6', year: 2012)
      FactoryGirl.create(:vehicle, make: 'Audi', model: 'A4', year: 2012)
      FactoryGirl.create(:vehicle, make: 'Audi', model: 'A4', year: 2013)
      get :years, {:make=> 'Audi', :model=> 'A4'}, :format => :json
      response.status.should be 200
      models = JSON.parse(response.body)
      models.size.should eql 2
    end

  end

end
