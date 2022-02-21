# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

10.times do
  user = User.create!(
    user_name: Faker::Name.name,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.first_name}#{Faker::Name.last_name}@gmail.com"
  )
  10.times do
    book = Book.new(
      title: Faker::Book.title,
      author: Faker::Book.author,
      suggested_price: 10.0
    )
    book.user = user
    book.save!
  end
end
