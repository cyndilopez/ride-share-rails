class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  # validates :phone_num, presence: true, format: { with: /\A^[2-9]\d{2}-\d{3}-\d{4}$\z/ }
  validates :phone_num, presence: true, format: { with: /\A^.?.?\d{3}.?.?\d{3}.?\d{4}[ ]*((x){0,1}([0-9]){1,5}){0,1}$\z/ }

  def total_charged
    completed_trips = trips.reject { |trip| trip.cost == nil }
    total = completed_trips.sum { |trip| trip.cost if trip.cost != nil }

    puts total
    return total / 100
  end
end
