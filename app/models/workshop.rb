class Workshop < ActiveRecord::Base

	extend FriendlyId


	ratyrate_rateable 'rating'

  friendly_id :title, use: :slugged
	belongs_to :user
	belongs_to :topic
	has_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :description, presence: true
	validates :location, presence: true, format: { with: /\A[a-zA-Z][a-zA-Z,\s]+[a-zA-Z], [a-zA-Z]{2}, [a-zA-Z][a-zA-Z,\s]+[a-zA-Z]\z/,
    message: "example: San Diago, CA, United States" }

  has_attached_file :image, styles: { medium: ["600x300>", :png], thumb: ["400x200>", :png] }, default_url: ActionController::Base.helpers.asset_path('workshop.jpg')
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.filter_topic(topic_id)
	  where("topic_id = ?", topic_id)
	end

	def self.filter_city(city)
		 where("location ILIKE ?", city)
	end

	def self.filter_city_and_topic(city, topic_id)
		where("location ILIKE ? AND topic_id = ?", city, topic_id)
	end

end
