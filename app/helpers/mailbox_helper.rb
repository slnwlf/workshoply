module MailboxHelper

	def unread_messages_count
		#get number of unread messages for current user
		mailbox.inbox(:unread => true).count(:id, :distinct => true)
	end

	
end
