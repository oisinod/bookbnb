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
10.times do
  user = User.create!(
    user_name: Faker::Name.name,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.first_name}#{Faker::Name.last_name}@gmail.com"
  )
  book["items"].first(10).each do |result|
    author = result["volumeInfo"]["authors"]
    author = "" if author.nil?
    photo_url = result["volumeInfo"]["imageLinks"]
    photo_url = "" if result["volumeInfo"]["imageLinks"].nil?
    new_book = Book.new(
      title: result["volumeInfo"]["title"],
      author: author[0],
      suggested_price: 10.0,
      photo_url: photo_url["thumbnail"]
    )
    new_book.user = user
    new_book.save
  end
end

# first_book = book["items"].first
# puts first_book["volumeInfo"]["title"]
# puts first_book["volumeInfo"]["imageLinks"]["thumbnail"]
