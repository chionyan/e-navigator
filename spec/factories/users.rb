require 'faker'

FactoryBot.define do
  pass = Faker::Internet.password(6,20)

  factory :user do
    username              Faker::Name.name
    email                 Faker::Internet.safe_email
    password              pass
    password_confirmation pass
    birthdate             Faker::Date.birthday(18, 65)
    sex                   [1,2,3].sample
  end
end