# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    sequence(:make) { |n| "Make#{n}" }
    sequence(:model) { |n| "Model#{n}" }
    sequence(:year) { |n| n }
    #model ""
    #year ""
  end
end
