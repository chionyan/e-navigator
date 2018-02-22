require 'dotenv'
Dotenv.load

class InterviewMailer < ApplicationMailer
  default from: ENV['SENDER_EMAIL_ADDRESS']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #

  def apply(src_user,dst_user)
    @src_user = src_user
    @dst_user = dst_user
    @approvaldate = @src_user.approvaldate
    mail(to: @src_user.email + "," + @dst_user.email, subject: '面接日程承認のお知らせ')
  end

  def order(src_user,dst_user)
    @src_user = src_user
    @dst_user = dst_user
    @approvaldate = @src_user.approvaldate
    mail(to: @dst_user.email, subject: '面接日程承認依頼のお知らせ')
  end
end
