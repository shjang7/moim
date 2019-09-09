# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[author friend] do
    name { Faker::FunnyName.two_word_name }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { Faker::Alphanumeric.alphanumeric(number: 6) }
  end
end
