class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    unless @trip
      redirect_to trips_path
      return
    end
    @driver = Driver.find_by(id: @trip.driver_id)
    @passenger = Passenger.find_by(id: @trip.passenger_id)
  end
end
