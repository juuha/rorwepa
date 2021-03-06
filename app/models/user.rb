class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30 }

  validates :password, length: { minimum: 4 },
                       format: { with: /(.*([A-Z].*\d)|(\d.*[A-Z]).*)/,
                                 message: "Must contain at least one number and one capital letter." }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def self.top(num)
    User.all.sort_by{ |u| -u.ratings.count }[0..(num - 1)]
  end
end
