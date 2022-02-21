# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'
require 'pry-byebug'

url = "https://www.googleapis.com/books/v1/volumes?q=science&key=AIzaSyCGZCM4CcDpgh-aNEYPQcsy-sKcwCEgwIs"
books = URI.open(url).read
book = JSON.parse(books)

10.times do
  user = User.create!(
    user_name: Faker::Name.name,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.first_name}#{Faker::Name.last_name}@gmail.com"
  )
  book.first(10) do |result|
    p result
    binding.pry
    new_book = Book.new(
      title: result["items"]["volumeInfo"]["title"],
      author: result["items"]["volumeInfo"]["authors"][0],
      suggested_price: 10.0,
      photo_url: result["items"]["volumeInfo"]["imageLinks"]["thumbnail"]
    )
    puts new_book
    new_book.user = user
    new_book.save!
  end
end

# first_book = book["items"].first
# puts first_book["volumeInfo"]["title"]
# puts first_book["volumeInfo"]["imageLinks"]["thumbnail"]
