class Location
  include Mongoid::Document

  field :address, type:String
  field :latitude, type:Float
  field :longitude, type:Float
  field :gmaps, type:Boolean

  acts_as_gmappable

  def gmaps4rails_address
    address
  end
end