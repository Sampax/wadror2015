class User < ActiveRecord::Base
  include AverageRating

  has_secure_password

  validates :username, uniqueness: true,
                       length: { in: 3..15 }

  validates :password, length: { minimum: 4 },
                       format: { with: /\d.*[A-Z]|[A-Z].*\d/, message: "Password must contain at least one number and one capital letter" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end