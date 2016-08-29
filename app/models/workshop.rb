class Workshop < ActiveRecord::Base

	extend FriendlyId
  friendly_id :title, use: :slugged
	belongs_to :user

	validates :title, presence: true
	validates :description, presence: true
	validates :location, presence: true

  has_attached_file :image, styles: { medium: ["600x300>", :png], thumb: ["400x200>", :png] }, default_url: ActionController::Base.helpers.asset_path('workshop.jpg')
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
