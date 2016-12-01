module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div id="error_explanation">
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_errors?
    resource.errors.full_messages.map { |msg| msg }.join.length > 0
  end

  def oauth_email_error!
    if resource.errors.empty? and resource.full_name and !resource.email
      html = <<-HTML
      <div id="error_explanation">
        <h4>You must allow Email to signup with Facebook</h4>
        <p>Steps to re-signup with Facebook</p>
        <ul>
          <li>Go to your Facebook</li>
          <li>Go to App Settings</li>
          <li>Remove BigTalker App</li>
          <li>Go back to BigTalker Sign Up Page</li>
          <li>Sign up again and make sure you allow email</li>
        </ul>
      </div>
      HTML

      html.html_safe
    end
  end
end