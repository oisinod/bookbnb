# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

url = "https://www.googleapis.com/books/v1/volumes?q=science&key=AIzaSyCGZCM4CcDpgh-aNEYPQcsy-sKcwCEgwIs"
books = URI.open(url).read
book = JSON.parse(books)
users = []
20.times do
  user = User.new(
    user_name: Faker::Name.name,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.first_name}#{Faker::Name.last_name}@gmail.com",
    location: Faker::Address.city
  )
  user.save!
  users.push(user)
end

book["items"].first(100).each do |result|
    author = result["volumeInfo"]["authors"]
    author = "" if author.nil?
    photo_url = result["volumeInfo"]["imageLinks"]
    photo_url = "" if result["volumeInfo"]["imageLinks"].nil?
    new_book = Book.new(
      title: result["volumeInfo"]["title"],
      author: author[0],
      suggested_price: rand(0.5..6.0),
      photo_url: photo_url["thumbnail"]
    )
    new_book.user = users.sample
    new_book.save!
    puts "book created with user: #{new_book.user}"
end


### SEED FOR BOOKINGS

# 50.times do

# 5.times do
#   booking = Booking.new(
#     price: 10,
#     start_date: Date.new(2022,2,22),
#     end_date: Date.new(2022,2,24),
#     status: "Booked"
#   )
#   booking.book = Book.find(8)
#   booking.user = User.find(2)
#   booking.save
#   end
