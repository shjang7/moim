# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    name { first_name + ' ' + last_name }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 6) }
  end
end
