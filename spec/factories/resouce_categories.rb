FactoryBot.define do

  factory :resource_category do

    name

    trait :unspecified do
      name { 'Unspecified' }
    end

  end

end