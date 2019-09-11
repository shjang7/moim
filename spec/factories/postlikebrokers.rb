# frozen_string_literal: true

FactoryBot.define do
  factory :post_like_broker do
    user
    post
  end
end
