class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books

    #array of the users books that you're looking at
    #iterate through each book to see its bookings
    # IF the booking has a review attached to it
    @users_reviews = []
    @books.each do |book|
      book.bookings.each do |booking|
        booking.review ? @users_reviews.push(booking.review) : next
      end
    end
    @total_score = 0
    @ratings = @users_reviews.each do |review|
      @total_score += review.rating
    end
    @average_rating = @total_score/@users_reviews.count
  end
end
