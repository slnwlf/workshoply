class Topic < ActiveRecord::Base
	has_many :workshops

	def titleize_name
		name.titleize
	end
end
