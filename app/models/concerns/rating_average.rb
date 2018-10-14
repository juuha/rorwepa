module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.empty? ? 0 : ratings.average(:score)
  end
end
