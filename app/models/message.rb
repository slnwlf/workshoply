class Message
	include ActiveModel::Model
	attr_accessor :form, :name, :email, :subject, :content, :company, :location, :number_participants, :budget, :audience, :date
	validates :name, :email, :subject, :content, :form, presence: {
							message: "is required"
						}
	validates :company, :location, :number_participants, :budget, presence: true, if: :request_for_speaker?
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	ContentToMessage = {
    content: "Message"
  }

  def self.human_attribute_name(attr, options = {})
    ContentToMessage[attr.to_sym] || super
  end

	def request_for_speaker?
		form == 'request'
	end

end
