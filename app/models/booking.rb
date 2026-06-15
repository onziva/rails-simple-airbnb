class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  has_one :review, dependent: :destroy

  validates :start_date, :end_date, presence: true
  validate :end_after_start

private
  def end_after_start
    return if start_date.blank? || end_date.blank?
    errors.add(:end_date, "doit être postérieure à la date de début") if end_date <= start_date
  end
end
