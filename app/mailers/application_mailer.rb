class ApplicationMailer < ActionMailer::Base
  default from: "hello.bigtalker@gmail.com"
  layout 'mailer'
end
