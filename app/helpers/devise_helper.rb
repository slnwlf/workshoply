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
end