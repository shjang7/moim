# Moim

This is part of the Final Project in The Odin Project’s Ruby on Rails Curriculum. <br />
Find it at [here](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).
"Moim" is a Korean word meaning "gathering".

## Function description

- Home
  * not login user: access signup / login / facebook login (future task)
    + sign up: with full name(more than 2 words) / email / password
    + login: with email / password
  * login user
    + write posts
    + see the posts which included in user or friends
      - like post
      - write comments
- Profile
  * user info: profile picture / name
  * friend info: friend count / 9th friend pic / all friend link('More') / 'Find Friend' link
  * the posts which was written by the profile's user
  * user self
    + edit user info: name / email / password / delete account
    + write / edit / delete post
  * others visiting one's page
    + able to request or accept friendship or seeing pending status
    + 'More': show all friends
- Find Friends
  * (n): received friendship request count
  * 'view sent request': pending friends, friendship requested, but wasn't accepted yet
  * 'Respond to your friend request': friend requests, waiting acceptances for friendship
  * 'Find Friends'
    + for unknowns, able to request friendship
- Log out : user log out
- Feedback : user sends feedback to producer's email
- Additional description
  * profile picture
    + if user log in with facebook, user can see facebook picture
    + if user log in without facebook, user doesn't have picture
      (except user email having gravatar account)

## Technology

- Bootstrap 4.0
- SCSS
- Ruby 2.6.3
- Rails 5.2.3

## deployment

https://rails-moim-suh.herokuapp.com

## Getting started

To get started with the app, clone the repository and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Then, load data from seed into the database:

```
$ rails db:seed
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server: <br />
When you used seed, example user info : email: "example@example.com", password: "foobar"

```
$ rails server
```

## Contributors

This is a solo project by me: [Suhyeon Jang](https://github.com/shjang7)


## Contributing

1. Fork it (https://github.com/shjang7/moim/fork)
2. Create your feature branch (git checkout -b feature/[choose-a-name])
3. Commit your changes (git commit -am 'what this commit will fix/add')
4. Push to the branch (git push origin feature/[chosen-name])
5. Create a new Pull Request


## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
