class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates :rating, :allow_nil => true, numericality: { greater_than: 0, less_than: 6 }

  def self.calc_cost
    cost = rand * 3000 + 200
    return cost.to_i
  end
end
