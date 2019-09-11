# frozen_string_literal: true

User.create!(
  name: 'Example User',
  email: 'example-0@example.com',
  password: 'foobar',
  profile_pic: 'cat-0.webp'
)

avatars = ['cat-1.webp', 'cat-2.webp', 'cat-3.webp',
           'cat-4.webp', 'cat-5.webp']

15.times do |i|
  name = Faker::FunnyName.two_word_name
  index = i + 1

  User.create!(
    name: name,
    email: "example-#{index}@example.com",
    password: 'foobar',
    profile_pic: avatars[i]
  )
end

users = User.order(:created_at)[-16..-1]

# Friend request
last_index = users.size - 1
main_user = users[last_index - 15]
asking_users = users[(last_index - 14)..(last_index - 13)]
receiving_users = users[(last_index - 12)..(last_index - 11)]
friends = users[(last_index - 10)..(last_index - 6)]
asking_users.each do |user|
  Friendship.create!(user_id: user.id,
                     friend_id: main_user.id,
                     confirmed: false)
end
receiving_users.each do |user|
  Friendship.create!(user_id: main_user.id,
                     friend_id: user.id,
                     confirmed: false)
end
friends.each_with_index do |user, i|
  Friendship.create!(user_id: main_user.id,
                     friend_id: user.id,
                     confirmed: true)
  next if i == last_index - i

  Friendship.create!(user_id: users[last_index - i].id,
                     friend_id: user.id,
                     confirmed: true)
end

# Post create
friends.each_with_index do |user, i|
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
  friends.each do |user|
    Comment.create!(
      content: Faker::Lorem.paragraph(sentence_count: 8),
      post_id: post.id,
      user_id: user.id,
      created_at: Faker::Date.between(from: 50.days.ago, to: Date.today)
    )
  end
end
