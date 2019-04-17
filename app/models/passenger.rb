class Passenger < ApplicationRecord
  has_many :trips

  def total_charged
    completed_trips = trips.reject { |trip| trip.cost == nil }
    total = completed_trips.sum { |trip| trip.cost }

    puts total
    return total / 100
  end
end
