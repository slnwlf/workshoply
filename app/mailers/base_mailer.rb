class BaseMailer < ActionMailer::Base

  protected

  def mail_with_bcc(headers={}, &block)
    headers.merge!(bcc: ENV['BCC_EMAIL'])
    mail_without_bcc(headers, &block)
  end
  alias_method_chain :mail, :bcc
end