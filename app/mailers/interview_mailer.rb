require 'dotenv'
Dotenv.load

class InterviewMailer < ApplicationMailer
  default from: ENV['SENDER_EMAIL_ADDRESS']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #

  def apply(interviewee,interviewer)
    @interviewee = interviewee
    @interviewer = interviewer
    mail(to: @interviewee.email + "," + @interviewer.email, subject: '面接日程承認のお知らせ')
  end

  def order(interviewee,interviewer)
    @interviewee = interviewee
    @interviewer = interviewer
    @interviewee_url = "https://e-navigator-chionyan.herokuapp.com/users/" + @interviewee.id.to_s + "/interviews"
    mail(to: @interviewer.email, subject: '面接日程承認依頼のお知らせ')
  end

end
