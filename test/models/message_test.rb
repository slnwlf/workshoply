require 'test_helper'

class MessageTest < ActiveSupport::TestCase
	test 'responds to name, email, subject and content'
	msg = Message.new
	[:name, :email, :subject, :content].each do |attr|
			assert msg.respond_to? attr
		end
	end

	test 'should accept valid attributes' do
		valid_attrs = {
			name: 'sam',
			email: 'sam@example.com',
			subject: 'hi',
			content: 'kthxbai'
		}
		msg = Message.new valid_attrs

		assert msg.valid?
	end

	test 'attributes cannot be blank' do
		msg = Message.new
		refute msg.valid?
	end

	test 'failed post' do
		post :create, message: {\
			name: '',
			email: '',
			subject: '',
			content: ''
		}
		[:name, :email, :subject, :content].each do |attr|
			assert_select 'li', "#{attr.capitalize} can't be black"
		end
	end

end
