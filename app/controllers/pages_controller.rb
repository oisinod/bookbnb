class PagesController < ApplicationController
  def home
  end

  def dashboard
    @books = current_user.books
    @all_books = Book.all
    @bookings = Booking.all
    @users = User.all
    @my_bookings = current_user.bookings
  end
end
