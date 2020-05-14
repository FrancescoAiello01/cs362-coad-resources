FactoryBot.define do

  factory :ticket do

    name
    region
    resource_category
    phone { '4512121212' }

    trait :open do
      closed { false }
    end

    trait :closed do
      closed { true }
      organization
    end

    trait :add_organization do
      organization
    end

  end

end