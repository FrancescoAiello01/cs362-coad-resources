FactoryBot.define do

  factory :region do

    name

    trait :unspecified do
      name { 'Unspecified' }
    end

  end

end