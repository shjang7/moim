# frozen_string_literal: true

unless User.find_by(first_name: 'Example', last_name: 'User')
  User.create!(
    name: 'Example User',
    email: 'example@example.com',
    password: 'foobar',
    profile_pic: 'cat-0.webp'
  )
end

avatars = ['cat-1.webp', 'cat-2.webp', 'cat-3.webp',
           'cat-4.webp', 'cat-5.webp']

5.times do |i|
  name = Faker::FunnyName.two_word_name
  User.create!(
    name: name,
    email: Faker::Internet.email(name: name),
    password: Faker::Alphanumeric.alphanumeric(number: 6),
    profile_pic: avatars[i]
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
