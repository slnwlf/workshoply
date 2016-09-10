require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase

	test "message me" do
		msg = Message.new(
			name: 'yoshi',
			email: 'yoshi@example.com',
			subject: 'hi',
			content: 'hello from the internet'
			)

		email = MessageMailer.message_me(msg).deliver_now

		refute ActionMailer::Base.deliveries.empty?
		assert_equal ['sam@example.com'], email.to
    assert_equal ['yoshi@example.com'], email.from
    assert_equal 'Hi', email.subject
    assert_equal 'Hello from the internet', email.body.to_s
  end
end