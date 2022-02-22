class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  has_many :bookings
  validates :first_name, :last_name, :user_name, :email, presence: true

  # TO DO MAKE METHOD - MY BOOKINGS
  # DB QUERY TO GET BOOKINGS OF MY BOOKS
end
