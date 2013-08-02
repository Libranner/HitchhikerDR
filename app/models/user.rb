class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :encrypted_password if :provider.nil? || :provider.empty?

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  field :name, type: String
  field :username, type: String
  field :provider, type: String
  field :uid, type: String
  field :image, type: String
  field :hitchhiker_type, type:Integer
  field :telephone, type:String
  field :driver, type: Boolean

  validates_presence_of :name
  validates_presence_of :uid
  validates :username, uniqueness: true, presence: true


  attr_accessible :name, :driver, :email, :image, :hitchhiker_type, :password, :password_confirmation, :remember_me,
                  :created_at, :updated_at,:username,:uid



  def driver?
    driver
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      #user.password = SecureRandom.hex(10)
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def trips_reservations
    ids = reservations.distinct(:trip_id)
    Trip.find(ids)
  end

  #Scopes
  scope :drivers, where(driver:true)
  scope :passengers, where(driver:false)

  has_many :trips
  has_many :reservations
end
