# frozen_string_literal: true

unless User.find_by(first_name: 'Example', last_name: 'User')
  User.create!(
    name: 'Example User',
    email: 'example-0@example.com',
    password: 'foobar',
    profile_pic: 'cat-0.webp'
  )
end

avatars = ['cat-1.webp', 'cat-2.webp', 'cat-3.webp',
           'cat-4.webp', 'cat-5.webp']

15.times do |i|
  name = Faker::FunnyName.two_word_name
  index = i + 1
  next if User.find_by(email: "example-#{index}@example.com")

  User.create!(
    name: name,
    email: "example-#{index}@example.com",
    password: 'foobar',
    profile_pic: avatars[i]
  )
end

# Post create
users = User.order(:created_at)[-16..-1]
users[-16..-10].each_with_index do |user, i|
  (i + 1).times do
    user.writing_posts.create!(
      content: Faker::Lorem.paragraph(sentence_count: 10),
      created_at: Faker::Date.between(from: 50.days.ago, to: Date.today)
    )
  end
end

# Post Like
post = Post.first
users.each { |liker| post.liker_add liker }

# Comment create
posts = Post.all
posts.each do |post|
  users[-9..-7].each do |user|
    Comment.create!(
      content: Faker::Lorem.paragraph(sentence_count: 8),
      post_id: post.id,
      user_id: user.id,
      created_at: Faker::Date.between(from: 50.days.ago, to: Date.today)
    )
  end
end

# Friend request
main_user = users[-16]
request_user = users[-15]
pending_user = users[-1]
Friendship.create!(user_id: main_user.id,
                   friend_id: pending_user.id,
                   confirmed: false)
Friendship.create!(user_id: request_user.id,
                   friend_id: main_user.id,
                   confirmed: false)
users[-14..-4].each do |friend|
  Friendship.create!(user_id: main_user.id,
                     friend_id: friend.id,
                     confirmed: true)
end
