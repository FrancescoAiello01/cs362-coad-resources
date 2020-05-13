FactoryBot.define do

  factory :ticket do

    name { 'FAKE' }
    phone { '4512121212' }
    region_id { "1234" }
    resource_category_id { "1234" }
    closed { nil }
    organization_id { nil }

    trait :open do
      closed { false }
      organization_id { nil }
    end

  end

end