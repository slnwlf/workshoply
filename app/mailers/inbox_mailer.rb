class InboxMailer < ApplicationMailer

	def admin_message(message, sender, receiver)
		@message = message
		@sender = sender
		@receiver = receiver
		mail to: 'dave.sloan@gmail.com', subject: 'BigTalker: A message has been sent between two users on BigTalker'
	end
end
