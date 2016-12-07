class InboxMailer < ApplicationMailer

	def admin_message(message, sender, receiver)
		@message = message
		@sender = sender
		@receiver = receiver
		mail to: 'dave.sloan@gmail.com', subject: 'Conversation between #{@sender.full_name} and from #{@receiver.full_name}'
	end
end
