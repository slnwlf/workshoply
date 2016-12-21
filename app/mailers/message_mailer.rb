class MessageMailer < ApplicationMailer

	default :to => ENV['BCC_EMAIL']
	def message_me(msg)
		@msg = msg
		mail from: "#{@msg.name} <#{@msg.email}>", subject: "#{@msg.subject}" do |format|
			format.html { render 'message_me.html.erb' }
		end
	end

end
