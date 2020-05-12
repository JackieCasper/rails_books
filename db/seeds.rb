# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
12.times do |_x|
  name = Faker::Book.unique.author
  email = Faker::Internet.email(name)
  @author = Author.create(
    name: name,
    email: email,
    email_confirmation: email
  )
  Book.create(
    title: Faker::Book.unique.title,
    genre: Faker::Book.genre,
    author_id: @author.id,
    pages: rand(5..800)
  )
end

30.times do |_x|
  Book.create(
    title: Faker::Book.unique.title,
    genre: Faker::Book.genre,
    author:Author.all.sample,
    pages:rand(5..800)
  )
end

puts "Created #{Author.count} Authors and #{Book.count} Books"
