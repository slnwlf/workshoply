class User < ActiveRecord::Base

	extend FriendlyId

  acts_as_messageable

  ratyrate_rater
  
  friendly_id :full_name, use: :slugged
  has_many :workshops, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  validates :full_name, presence: true
  validates :location, presence: true, format: { with: /\A[a-zA-Z][a-zA-Z,\s]+[a-zA-Z], [a-zA-Z]{2}, [a-zA-Z][a-zA-Z,\s]+[a-zA-Z]\z/,
    message: "example: San Diego, CA, United States" }, unless: -> { from_omniauth? }
  validates :organization, presence: true, unless: -> { from_omniauth? }
  validates :bio, length: { minimum: 40, maximum: 1000,
    too_long: "%{count} characters is the maximum allowed", on: :update,
    too_short: "%{count} characters is the minimum allowed" }, on: :update

  has_attached_file :avatar, 
    styles: { medium: "300x300>", thumb: "100x100>" }, 
    default_url: "https://s3-us-west-1.amazonaws.com/bigtalker/assets/images/no-image.jpg"
  validates_attachment_content_type :avatar, content_type: ['image/gif', 'image/jpeg', 'image/png', 'image/x-ms-bmp']

  def mailboxer_name
    self.full_name
  end

  def mailboxer_email(object)
    return email
  end


  # facebook
  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.full_name = auth.info.name
     user.confirmed_at = Time.zone.now
     user.skip_confirmation!
     # return nil is email already taken
     return nil unless user.save and user.email
   end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.full_name = data["name"] if user.full_name.blank?
      end
    end
  end

  private

  def from_omniauth?
    provider && uid and self.new_record?
  end
  
end
