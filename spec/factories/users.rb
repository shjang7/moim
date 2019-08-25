# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    name { Faker::FunnyName.two_word_name }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 6) }
  end
end
