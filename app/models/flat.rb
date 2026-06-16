class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews,  through: :bookings           # avis du logement

  has_one_attached :photo

  geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :description, :address, presence: true
  validates :price_by_night, :capacity, numericality: { greater_than: 0 }
end
