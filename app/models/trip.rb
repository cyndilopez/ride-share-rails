class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  def self.calc_cost
    cost = rand * 3000 + 200
    return cost.to_i
  end
end
