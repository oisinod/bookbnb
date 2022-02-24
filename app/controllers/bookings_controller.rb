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
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    @booking = Booking.find(params[:id])
    params[:q].to_i == 1 ? @booking.status = "confirmed" : @booking.status = "declined"
    @booking.save
    redirect_to dashboard_path, notice: "Booking #{@booking.status} successfully"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price, :status)
  end
end
