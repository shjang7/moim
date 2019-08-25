# frozen_string_literal: true

3.times do
  name = Faker::FunnyName.two_word_name
  User.create!(
    name: name,
    email: Faker::Internet.email(name: name),
    password: Faker::Alphanumeric.alphanumeric(number: 6),
    profile_pic: Faker::Avatar.image(slug: name, size: "80x80")
  )
end

users = User.all
users.each do |user|
  2.times do
    user.writing_posts.create!(
      content: Faker::Games::LeagueOfLegends.quote
    )
  end
end
