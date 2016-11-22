User.create!(name: "Example User",
  email: "admin@gmail.com",
  password_digest: "foobar",
  is_admin: true)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.com"
  password_digest = "password"
  User.create!(name: name,
    email: email,
    password_digest: "foobar",
    is_admin: false)
end
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
