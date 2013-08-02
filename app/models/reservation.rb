class Reservation
  # To change this template use File | Settings | File Templates.

  include Mongoid::Document
  field :sits, type:Integer
  field :date, type:DateTime

  belongs_to :user
  belongs_to :trip


  attr_accessible :sits, :date,:user,:trip
end