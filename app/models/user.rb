class User < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  has_many :bookings
  validates :first_name, :last_name, :user_name, :email, :location, presence: true

  # TO DO MAKE METHOD - MY BOOKINGS
  # DB QUERY TO GET BOOKINGS OF MY BOOKS
  def my_bookings
    @user = self
    @bookings = Booking.where("user_id = :id", id: @user.id)
  end
end
