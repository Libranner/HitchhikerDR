#require 'will_paginate/mongoid'
class Trip
  include Mongoid::Document
  field :from, type: String
  field :to, type: String
  field :status, type: Integer, default: 1
  field :frequency, type: Integer, default: 1
  field :conditions, type: String
  field :departure, type: DateTime
  field :arrive, type: DateTime
  field :sits, type:Integer

  #has_many :checks  #, :dependent => :destroy
  belongs_to :user
  has_many :reservations

  scope :actives, where(status: 1)

  validates_numericality_of :sits
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :departure
  validates_presence_of :arrive


  attr_accessible :to,:from,:status,:frequency,:conditions,:departure,:arrive,:sits,:reservations
  #scope :trips_of_user, ->(user_id){where(checkins.user_id: user_id)}

  def available_sits
    sits_taked =0
    self.reservations.each do |check|
      sits_taked += check.sits unless check.user_id.nil?
    end
    sits - sits_taked
  end

  def users_checkin
    ids = reservations.distinct(:user_id)
    User.find(ids)
  end

  def driver
    self.user
  end

  def self.search(search, page)
    if search
      trips = any_of({:from => /#{search}/i}, {:to => /#{search}/i})
      trips.paginate :per_page => 10, :page => page,
               :order => 'to'
    else
      paginate :per_page => 10
    end
  end

  def add_reservation(user, sits)
    #CheckIn check = CheckIn.new(user_id: user.id, sits: sits, date: Time.now)
    #CheckIn check2 = CheckIn.new(user: user, sits: sits, date: Time.now)
   # User check3 = User.new(sits: sits, date: Time.now)
    #check3.user = user
    #debugger
    #user.check_ins.create(sits: sits, date: Time.now)
    #debugger

    self.reservations.create!(user: user, sits: sits, date: Time.now)
  end

  def destroy_reservation(user)
    self.reservations.delete_all(user_id: user.id)
    user.reservations.delete_all(user_id: user.id)
  end
end
