class InboxMailer < ApplicationMailer

	def admin_message(message, sender, receiver)
		@message = message
		@sender = sender
		@receiver = receiver
		mail to: ENV['BCC_EMAIL'], subject: "Conversation between #{@sender.full_name} and #{@receiver.full_name}"
	end
end
