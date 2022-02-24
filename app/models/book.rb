class Book < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :title, :author, :suggested_price, presence: true
  validates :suggested_price, numericality: { only_float: true }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :author, :description ],
    associated_against: {
      user: [ :user_name, :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
