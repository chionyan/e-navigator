require 'faker'

FactoryBot.define do
  factory :interview do
    association :user
    sequence(:id) { |n| n }
    datetime { Faker::Time.forward(rand(7..100), :all) }
    interview_status  ["保留","承認","却下"].sample
  end
end
