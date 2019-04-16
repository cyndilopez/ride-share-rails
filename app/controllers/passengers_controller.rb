class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger = Passenger.new passenger_params
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
