class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum sex: { male: 1, famale: 2 , other: 3 }

  has_many :interviews

  def age
    return unless birthdate

    date_format = "%Y%m%d"
    today = Date.today
    (today.strftime(date_format).to_i - birthdate.strftime(date_format).to_i) / 10000
  end

  def approvaldate
    approval_interview = interviews.find_by(interview_status: "承認")
    if approval_interview
      approval_interview.interview_date_format
    else
      nil
    end
  end
  
end
