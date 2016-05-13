FactoryGirl.define do
  factory :transaction do
    transient do
      load false
      online false
    end

    mondo_id { Faker::Number.number(10) }
    data do
      {
        is_online: online,
        is_load: load,
        currency: 'GBP',
        amount: Faker::Number.between(1, 100)
      }
    end
  end
end
