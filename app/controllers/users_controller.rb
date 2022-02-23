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
  end
end
