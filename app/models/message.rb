class Message
	include ActiveModel::Model
	attr_accessor :form, :name, :email, :subject, :content, :company, :location, :number_participants, :budget, :audience, :date
	validates :name, :email, :subject, :content, presence: true

end
