class Passenger < ApplicationRecord
  has_many :trips

  def total_charged
    total = trips.sum { |trip| trip.cost }

    puts total
    return total / 100
  end
end
