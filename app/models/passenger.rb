class Passenger < ApplicationRecord
  has_many :trips

  def total_cost
  end
end
