FactoryBot.define do

  factory :ticket do

    name
    region
    resource_category
    phone { '4512121212' }
    closed { false }

    trait :open do
      closed { false }
    end

  end

end