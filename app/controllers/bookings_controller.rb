class BookingsController < ApplicationController
  before_action :set_flat,    only: %i[new create]
  before_action :set_booking, only: %i[show destroy]

  def index
    @bookings = Booking.all   # TODO : current_user.bookings une fois Devise en place
  end

  def show
    @review = Review.new      # alimente le formulaire d'avis de la page show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.flat = @flat                         # le flat vient de l'URL, pas du formulaire

    if @booking.start_date && @booking.end_date   # total_price calculé : nuits × prix
      nights = (@booking.end_date - @booking.start_date).to_i
      @booking.total_price = nights * @flat.price_by_night
    end

    if @booking.save
      redirect_to @booking, notice: "Réservation enregistrée."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Réservation annulée.", status: :see_other
  end

  private

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id)
  end
end
