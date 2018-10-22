class Brewery < ApplicationRecord
  extend TopN
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  @p = proc { Time.now.year }

  validates :name, length: { minimum: 1 }
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   less_than_or_equal_to: @p.call,
                                   only_integer: true }

  scope :active, -> { where active: true }
  scope :inactive, -> { where active: [nil, false] }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def self.top(num)
    top_refractored(num)
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
