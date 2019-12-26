FactoryBot.define do
  factory :friendship do
    user
    friend
    confirmed { false }
  end
end
