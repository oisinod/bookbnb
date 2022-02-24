class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @review.booking = @booking
    if @review.save
     redirect_to dashboard_path(q:"completed")
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
