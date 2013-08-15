# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    from "Santo Domingo"
    to "San Cristobal"
    status 1
    frequency 1
    conditions "Conditions"
    start_time Time.now
    finish_time Time.now
    sits 2
    association :user, factory: :driver
  end
end
