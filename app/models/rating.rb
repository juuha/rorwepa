class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
    "#{beer.name} --- #{score}, by #{user.username} at #{created_at}"
  end

  scope :recent, -> { Rating.order(:updated_at).last(3).reverse }
end
