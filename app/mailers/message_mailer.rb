class MessageMailer < ApplicationMailer

	default :to => "dave@bigtalker.io"
	def message_me(msg)
		@msg = msg
		mail from: @msg.email, subject: @msg.subject, body: 'Company: ' + @msg.company + ', Location: ' + @msg.location + ', Number of Participants: ' + @msg.number_participants + ', Budget: ' + @msg.budget + ', Who is the audience? ' + @msg.audience + ', Potential date: ' + @msg.date + ', Speaker Requirements: ' + @msg.content
	end

end
