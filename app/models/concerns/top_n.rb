module TopN
  extend ActiveSupport::Concern

  def top_refractored(num)
    all.sort_by{ |b| - b.average_rating }[0..(num - 1)]
  end
end
