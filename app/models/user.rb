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
         :confirmable

  validates :full_name, presence: true
  validates :location, presence: true, format: { with: /\A[a-zA-Z][a-zA-Z,\s]+[a-zA-Z], [a-zA-Z]{2}, [a-zA-Z][a-zA-Z,\s]+[a-zA-Z]\z/,
    message: "example: San Diego, CA, United States" }
  validates :organization, presence: true
  validates :bio, length: { minimum: 40, maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }, on: :update

  has_attached_file :avatar, 
    styles: { medium: "300x300>", thumb: "100x100>" }, 
    default_url: "https://s3-us-west-1.amazonaws.com/bigtalker/assets/images/no-image.jpg"
  validates_attachment_content_type :avatar, content_type: ['image/gif', 'image/jpeg', 'image/png', 'image/x-ms-bmp']

  def mailboxer_name
    self.full_name
  end

  def mailboxer_email(object)
    # self.email
    email
  end
  
end
