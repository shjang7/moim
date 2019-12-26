FactoryBot.define do
  factory :post do
    author
    content { Faker::Games::WorldOfWarcraft.quote }
  end
end
