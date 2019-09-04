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
  next if User.find_by(email: "example-#{i}@example.com")
  User.create!(
    name: name,
    email: "example-#{i}@example.com",
    password: 'foobar',
    profile_pic: avatars[i]
  )
end

# Post create
users = User.order(:created_at)[-5..-1]
users.each_with_index do |user, i|
  i.times do
    user.writing_posts.create!(
      content: Faker::Lorem.paragraph(sentence_count: 10),
      created_at: Faker::Date.between(from: 50.days.ago, to: Date.today)
    )
  end
end

# Post Like
# users = User.order(:created_at)[-5..-1]
# user = users.first
post = Post.first
likers = users[-3..-1]
likers.each { |liker| post.liker_add liker }

# Comment create
posts = Post.all
posts.each do |post|
  users[0..-4].each do |user|
    Comment.create!(
      content: Faker::Lorem.paragraph(sentence_count: 7),
      post_id: post.id,
      user_id: user.id,
      created_at: Faker::Date.between(from: 50.days.ago, to: Date.today)
    )
  end
end
