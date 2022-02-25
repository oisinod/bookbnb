class PagesController < ApplicationController
  def home
  end

  def dashboard
    @books = current_user.books
    @all_books = Book.all
    @bookings = Booking.all
    @users = User.all
    @my_bookings = current_user.bookings
    @total_bookings = total_bookings
    @review = Review.new

    @my_reviews = []
    @books.each do |book|
      book.bookings.each do |booking|
        booking.review ? @my_reviews.push(booking.review) : next
      end
    end
  end

  def total_bookings
    bookings = current_user.books.map do |book|
      book.bookings.where(status: "pending").count
    end
    bookings.sum
  end

  def total_reviews
    bookings = current_user.books.map do |book|
      book.bookings.where(status: "completed").count
    end
  end
end
