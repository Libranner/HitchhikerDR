class Check
  include Mongoid::Document
  field :sits, type:Integer
  field :date, type:DateTime

  belongs_to :user
  belongs_to :trip


  attr_accessible :sits, :date
end