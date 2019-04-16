class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])

    unless @passenger
      redirect_to passengers_path
      return
    end

    @trips = @passenger.trips
  end
end
