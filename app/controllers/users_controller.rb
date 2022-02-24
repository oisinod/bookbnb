class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @review = Review.new
    # TO DO: Add pundit to here as it will otherwise show the bookings of all users?
    @outgoing_bookings = @user.my_bookings
    @total_reviews = total_reviews(@user)
    @reviews = my_reviews(@user)
    @user = User.find(params[:id])
  end

  def total_reviews(user)
    total = 0
    user.books.select do |b|
       b.bookings.each do |r|
       total += 1 if r.review
       end
     end
     total
     raise

     #TO DO FIX THIS
  end

  def my_reviews(user)
    reviews = user.books.map do |book|
      book.bookings.where(status: "confirmed")
    end
    reviews.select {|booking| booking.length > 0}
  end
end
