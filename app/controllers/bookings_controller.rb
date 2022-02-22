class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new

    @book = Book.find(params[:book_id])
    @booking = Booking.new
  end

  def create
    @book = Book.find(params[:book_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.book = @book
    if @booking.save!
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price, :status)
  end
end
