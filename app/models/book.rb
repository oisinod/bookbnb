class Book < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :title, :author, :suggested_price, presence: true
  validates :suggested_price, numericality: { only_float: true }
end
