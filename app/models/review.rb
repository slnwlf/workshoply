class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :workshop

	validates :text, presence: true, length: { minimum: 100, maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }
end
