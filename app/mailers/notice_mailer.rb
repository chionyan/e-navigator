require 'dotenv'
Dotenv.load

class NoticeMailer < ApplicationMailer
  
  default from: ENV['SENDER_EMAIL_ADDRESS']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm(user)
    @user = user
    @approvaldate = @user.approvaldate
    mail to: @user.email, subject: "面接日程決定のお知らせ"
  end
end
