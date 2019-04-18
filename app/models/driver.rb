class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def total_earned
    finished_trips = trips.reject { |trip| trip.cost == nil }
    total = finished_trips.sum { |trip| ((trip.cost / 100) - 1.65) * 0.8 }
    return total.round(2)
  end

  def average_rating
    finished_trips = trips.reject { |trip| trip.rating == nil }
    total = finished_trips.sum { |trip| trip.rating }
    total /= trips.count.to_f
    return total.round(2)
  end

  def self.find_driver
    return Driver.all.sample
  end
end
