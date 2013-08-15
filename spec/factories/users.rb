# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:username) { |n| "testUser#{n}" }
    uid {"#{username}00"}
    email {"#{username}@hitchhikerdr.com"}
    password '12345678'
    password_confirmation '12345678'
    telephone 8095281111
    driver false

    factory :driver do
      driver true
    end
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
