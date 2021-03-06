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
book_list = []

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

book["items"].each do |result|
    author = result["volumeInfo"]["authors"]
    author = "Unknown" if author.nil?
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
    book_list.push(new_book)
end

### SEED FOR BOOKINGS

100.times do
  booking = Booking.new(
    price: rand(0.5..6.0),
    start_date: Date.new(2022,2,22),
    end_date: Date.new(2022,2,24),
    status: "Booked"
  )
  booking.book = book_list.sample
  booking.user = users.sample
  booking.save!
end
