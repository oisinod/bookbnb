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
  end

  def total_bookings
    bookings = current_user.books.map do |book|
      book.bookings.where(status: "pending").count
    end
    bookings.sum
  end
end
