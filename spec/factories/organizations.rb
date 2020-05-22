FactoryBot.define do

  factory :organization do

    name
    phone { '4512121212' }
    email
    status { :approved }
    primary_name { 'fake_name' }
    secondary_name { 'fake_name' }
    secondary_phone { '8888888888' }

    trait :set_submitted do
      status { :submitted }
    end

    trait :set_rejected do
      status { :rejected }
    end

  end

end