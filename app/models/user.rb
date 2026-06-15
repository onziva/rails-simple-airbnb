class User < ApplicationRecord
  has_many :flats,    dependent: :destroy          # logements hébergés
  has_many :bookings, dependent: :destroy          # ses réservations
  has_many :reviews,  through: :bookings           # avis qu'il a laissés

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_name
    "#{first_name} #{last_name}"
  end
end
