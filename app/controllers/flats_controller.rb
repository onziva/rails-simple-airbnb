class FlatsController < ApplicationController
  before_action :set_flat, only: %i[show edit update destroy]

  def index
    @flats = Flat.all

    # Recherche texte (nom ou adresse) — ILIKE = insensible à la casse (PostgreSQL)
    if params[:query].present?
      @flats = @flats.where("name ILIKE :q OR address ILIKE :q", q: "%#{params[:query]}%")
    end

    # Filtre : capacité minimale
    @flats = @flats.where("capacity >= ?", params[:capacity]) if params[:capacity].present?

    # Filtre : prix maximum par nuit
    @flats = @flats.where("price_by_night <= ?", params[:max_price]) if params[:max_price].present?
  end

  def show
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to @flat, notice: "Logement créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @flat.update(flat_params)
      redirect_to @flat, notice: "Logement mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, notice: "Logement supprimé.", status: :see_other
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :description, :address, :price_by_night, :capacity, :user_id)
  end
end
