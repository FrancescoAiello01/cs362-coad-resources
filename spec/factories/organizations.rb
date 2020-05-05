FactoryBot.define do

  factory :organization do

    name { 'FAKE' }
    phone { '4512121212' }
    email { 'email@email.com' }
    status { 1 }
    primary_name { 'fake_name' }
    secondary_name { 'fake_name' }
    secondary_phone { '8888888888' }

  end

end