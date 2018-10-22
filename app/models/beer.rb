class Beer < ApplicationRecord
  extend TopN
  include RatingAverage

  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }, presence: true
  validates :style, length: { minimum: 1 }

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def self.top(num)
    top_refractored(num)
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
