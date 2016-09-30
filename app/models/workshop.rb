class Workshop < ActiveRecord::Base

	extend FriendlyId


	ratyrate_rateable 'rating'

  friendly_id :title, use: :slugged
	belongs_to :user
	belongs_to :topic
	has_many :reviews, dependent: :destroy

	validates :topic_id, presence: true
	# validates :price, :numericality => { :greater_than_or_equal_to => 0 }
	validates :title, presence: true
	validates :description, presence: true


  has_attached_file :image, 
  	styles: { medium: "600x300>", thumb: "400x200>" },
  	default_url: "https://s3-us-west-1.amazonaws.com/bigtalker/assets/images/workshop.jpg"
  validates_attachment_content_type :image, content_type: ['image/gif', 'image/jpeg', 'image/png', 'image/x-ms-bmp']

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
