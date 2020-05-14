FactoryBot.define do

  factory :organization do

    name
    phone { '4512121212' }
    email
    status { :approved }
    primary_name { 'fake_name' }
    secondary_name { 'fake_name' }
    secondary_phone { '8888888888' }

  end

end