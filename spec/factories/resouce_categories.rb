FactoryBot.define do

  factory :resource_category do

    name { 'FAKE' }

    trait :unspecified do
      name { 'Unspecified' }
    end

  end

end