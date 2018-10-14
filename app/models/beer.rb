class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }, presence: true
  validates :style, length: { minimum: 1 }

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def self.top(num)
    Beer.all.sort_by{ |b| - b.average_rating }[0..(num - 1)]
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
