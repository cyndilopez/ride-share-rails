class Driver < ApplicationRecord
  has_many :trips

  def total_earned
    total = trips.sum { |trip| trip.cost / 100 }
    return total
  end
end
