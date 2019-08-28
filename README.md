# Moim

This is part of the Final Project in The Odin Project’s Ruby on Rails Curriculum. <br />
Find it at [here](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).
Moim is a Korean word meaning "gathering".

## deployment

https://rails-moim-suh.herokuapp.com

## Function description

- Home
  * not login user : access signup / login
  * login user
    + writes post
    + sees the posts which included in user or friends
      (future task, for now, seeing all)
- Profile
  * user self
    + see user info : profile picture / name
    + edit user info : written in additional description
    + writes post
    + sees the posts which was written by user
  * user visiting one's page
    + sees one's user info : profile picture / name
    + sees the posts which was written by one's
- Find Friends : future task
- Log out : user log out
- Additional description
  * Sign up
    + with full name(more than 2 words) / email / password
    + if user doesn't have gravatar
  * Log in
    + with email / password
    + with facebook (future task)
  * profile picture
    + if user log in with facebook, user can see facebook picture
    + if user log in without facebook, user doesn't have picture
      (except user email having gravatar account)
  * Edit info : included profile
    + with name / email / password
  * Delete account : remove account with writing posts
  * Writing post : included profile / home
    + with content for no limited words
  * Seeing post : included profile / home
    + with profile pic / name / created date / content
    + post author can delete post
  * Feedback : user can send us feedback through email

## Technology

- Ruby 2.6.3
- Rails 5.2.3

## Getting started

To get started with the app, clone the repo and then install the needed gems:

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
