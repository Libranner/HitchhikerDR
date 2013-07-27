class Vehicle
  include Mongoid::Document
  field :make, type: String
  field :model, type: String
  field :year, type: Integer
end
