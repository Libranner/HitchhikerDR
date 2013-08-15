#require 'will_paginate/mongoid'
class Trip
  include Mongoid::Document
  field :from, type: String
  field :to, type: String
  field :status, type: Integer, default: 1
  field :frequency, type: Integer, default: 0
  field :conditions, type: String
  field :start_time, type: DateTime
  field :finish_time, type: DateTime
  field :sits, type:Integer

  ##destination
  #include Mongoid::Document
  #
  #field :address, type:String
  #field :coordinates, :type => Array
  #
  #include Geocoder::Model::Mongoid
  #geocoded_by :address
  #after_validation :geocode



  #has_many :checks  #, :dependent => :destroy
  belongs_to :user
  has_many :reservations
  #has_one :destination

  scope :actives, where(status: 1)

  validates_numericality_of :sits
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :start_time
  validates_presence_of :finish_time

  attr_accessible :to,:from,:status,:frequency,:conditions,:start_time,:finish_time,:sits,:reservations
  #scope :trips_of_user, ->(user_id){where(checkins.user_id: user_id)}
  #
  #def near_destination
  #  loc = Location.new
  #  loc.address = to
  #  loc.geocode
  #  debugger
  #  loo = loc.nearbys(10)
  #  roo =Geocoder.search("New York, NY, USA")
  #  coord = Geocoder.search('New York, NY, USA').first.coordinates
  #  debugger
  #  result = Location.near(coord)
  #  result
  #end

  def available_sits
    sits_taked =0
    self.reservations.each do |check|
      sits_taked += check.sits unless check.user_id.nil?
    end
    sits - sits_taked
  end

  def from_coordinates
    coordinates(self.from)
  end

  def to_coordinates
    coordinates(self.to)
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
      paginate :per_page => 10, :page => page,
               :order => 'to'
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


  #DateTime Picker
  attr_accessible :js_start_time, :js_finish_time

  def time_format(time)
    time.present? ? time.localtime.strftime("%m/%d/%Y %I:%M:%S %p") : time
  end

  def parse_us_time(time)
    time_with_zone = "#{time} #{DateTime.now.strftime("%z")}"
    DateTime.strptime(time_with_zone,"%m/%d/%Y %I:%M:%S %p %z").to_time
  end

  # assuming your database column is called start_time
  def js_start_time=(time)
    if time.present?
      write_attribute :start_time, parse_us_time(time)
    else
      write_attribute :start_time, time
    end
  end

  # assuming your database column is called start_time
  def js_start_time
    time = read_attribute :start_time
    time_format(time)
  end

  def js_finish_time=(time)
    if time.present?
      write_attribute :finish_time, parse_us_time(time)
    else
      write_attribute :finish_time, time
    end
  end

  # assuming your database column is called start_time
  def js_finish_time
    time = read_attribute :finish_time
    time_format(time)
  end


  private
    def coordinates(address)
      location = Location.new
      location.address = address
      location.process_geocoding
      [location.latitude, location.longitude]
    end

  #validate do
    #errors.add(:start_time, 'too many teams') if start_time > finish_time
  #end
end
