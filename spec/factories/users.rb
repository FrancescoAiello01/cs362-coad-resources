FactoryBot.define do

  factory :user do

    email
    password { "password123" }
    password_confirmation { "password123" }

    trait :set_admin do
      role { :admin }
    end

  end

end