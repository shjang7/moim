# frozen_string_literal: true

5.times do
  name = Faker::FunnyName.two_word_name
  User.create!(
    name: name,
    email: Faker::Internet.email(name: name),
    password: Faker::Alphanumeric.alphanumeric(number: 6),
    profile_pic: Faker::Avatar.image(slug: name, size: "80x80")
  )
end

users = User.order(:created_at)[-5..-1]
users.each_with_index do |user, i|
  i.times do
    user.writing_posts.create!(
      content: Faker::Quotes::Shakespeare.hamlet_quote,
      created_at: Faker::Date.between(from: 50.days.ago, to: Date.today)
    )
  end
end
