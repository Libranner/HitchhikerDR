require 'spec_helper'

describe Trip do

  before :each do

    @driver = FactoryGirl.create(:user, username: 'lsantos')
    @trip = FactoryGirl.create(:trip,:sits=> 3)
    @driver.trips.create(sits: 2)
    @user = FactoryGirl.create(:user)
  end
  describe "Check in" do
    #it "Passenger check in in trip" do
    #  trip = FactoryGirl.create(:trip)
    #  trip.available_sits = trip.available_sits - 1
    #  put :update, {:id => trip.to_param, :available_sits => trip.available_sits}, valid_session
    #  trip.available_sits.should eql 1
    #end

    it "Passenger check in a trip" do
      @trip.add_reservation(@user,2)
      @trip.available_sits.should eql 1
    end

    it "Destroy check in a trip" do
      trip = FactoryGirl.create(:trip,:sits=> 3)
      trip.add_reservation(@user,2)
      trip.destroy_reservation(@user)
      trip.available_sits.should eql 3
    end


    it "Users checked in" do
      user2 = FactoryGirl.create(:user)
      trip = FactoryGirl.create(:trip,:sits=> 3)
      trip.add_reservation(@user,2)
      trip.add_reservation(user2,1)
      trip.users_checkin.size.should eql 2
    end

  end

  describe "Driver" do
    it 'should get driver data' do
      driver = @trip.driver
      driver.should be_kind_of User
    end
  end

  describe 'Searching' do
    it 'should return trips with that pass search criteria' do
      FactoryGirl.create(:trip, to: 'Santo Domingo', from: 'Azua')
      FactoryGirl.create(:trip, to: 'Azua', from: 'San Juan')
      FactoryGirl.create(:trip, to: 'Bonao', from: 'San Juan')
      FactoryGirl.create(:trip, to: 'Moca', from: 'Bonao')
      FactoryGirl.create(:trip, to: 'San Juan', from: 'Azua')
      FactoryGirl.create(:trip, to: 'Azua', from: 'San Juan')

      trips = Trip.search('Azua',1)
      trips.size.should eql 4

    end
  end

end
