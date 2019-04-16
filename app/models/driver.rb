class Driver < ApplicationRecord
  has_many :trips

  def total_earned
    total = trips.sum { |trip| trip.cost / 100 }
    return total
  end

  def average_rating
    total = trips.sum { |trip| trip.rating }
    total /= trips.count.to_f
    return total.round(2)
  end
end
