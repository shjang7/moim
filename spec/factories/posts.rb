FactoryBot.define do
  factory :post do
    content { Faker::Games::WorldOfWarcraft.quote }
    # user_id { create(:user).id }
  end
end
