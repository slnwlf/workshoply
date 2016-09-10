require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

test "succesful post" do
  assert_difference 'ActionMailer::Base.deliveries.size', 1 do
    post :create, message: {
      name: 'yoshi',
      email: 'yoshi@example.com',
      subject: 'hi',
      content: 'bye'
    }
  end

  assert_redirected_to new_message_path
  last_email = ActionMailer::Base.deliveries.last

  assert_equal "hi", last_email.subject
  assert_equal 'sam@example.com', last_email.to[0]
  assert_equal 'yoshi@example.com', last_email.from[0]
  assert_match(/bai/, last_email.body.to_s)

  ActionMailer::Base.deliveries.clear
end

end
