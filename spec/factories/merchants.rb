FactoryGirl.define do
  factory :merchant do
    address { Faker::Address.street_address }
    name { Faker::Commerce.name }
    mondo_id { Faker::Number.number(10) }

    trait :with_foursquare do
      foursquare_id { Faker::Number.number(10) }
    end

    trait :with_emoji do
      emoji '❤️'
    end
  end
end
