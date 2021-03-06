class Booking < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_one :review, dependent: :destroy
  validates :price, presence: true, numericality: { only_float: true }
  validates :start_date, :end_date, presence: true
end
