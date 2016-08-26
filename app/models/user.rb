class User < ActiveRecord::Base

	extend FriendlyId
  has_many :workshops
  friendly_id :full_name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :full_name, presence: true

  has_attached_file :avatar, styles: { medium: ["300x300>", :png], thumb: ["100x100>", :png] }, default_url: "http://www.humanecology.rutgers.edu/images/facfaces/NO-IMAGE-AVAILABLE.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
