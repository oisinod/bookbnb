class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  has_many :bookings
  has_many :bookings, through: :books
  validates :first_name, :last_name, :user_name, :email, presence: true
end
