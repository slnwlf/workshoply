class User < ActiveRecord::Base

	extend FriendlyId

  ratyrate_rater
  
  friendly_id :full_name, use: :slugged
  has_many :workshops
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :full_name, presence: true
  validates :location, presence: true, format: { with: /\A[a-zA-Z][a-zA-Z,\s]+[a-zA-Z], [a-zA-Z]{2}, [a-zA-Z][a-zA-Z,\s]+[a-zA-Z]\z/,
    message: "example: San Diego, CA, United States" }
  validates :organization, presence: true
  validates :bio, length: { minimum: 100, maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }

  has_attached_file :avatar, styles: { medium: ["300x300>", :png], thumb: ["100x100>", :png] }, default_url: "http://www.humanecology.rutgers.edu/images/facfaces/NO-IMAGE-AVAILABLE.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
