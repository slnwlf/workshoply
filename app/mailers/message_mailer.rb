class MessageMailer < ApplicationMailer

	default :to => "dave@bigtalker.io"
	def message_me(msg)
		@msg = msg
		mail from: @msg.email, subject: 'BigTalker: New Contact/Request a Speaker Form Received' do |format|
			format.html { render 'message_me.html.erb' }
		end
	end

end
