class ReviewsController < ApplicationController
  before_action :set_booking

  def create
    unless @booking.reviewable?
      return redirect_to @booking, alert: "Vous ne pouvez laisser un avis qu'une fois le séjour terminé."
    end

    @review = Review.new(review_params.merge(booking: @booking))
    if @review.save
      redirect_to @booking, notice: "Merci pour votre avis !"
    else
      render "bookings/show", status: :unprocessable_entity   # réaffiche la page show avec les erreurs
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
