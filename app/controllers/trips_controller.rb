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

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new
    driver = Driver.find_driver
    @trip.driver_id = driver.id
    @trip.date = Date.today
    passenger_id = params[:passenger_id]
    @trip.passenger_id = passenger_id
    @trip.save

    redirect_to passenger_path(passenger_id)
  end

  def update
    unrated_trip = Trip.find_by(id: params[:id])
    new_rating = params[:rating]
    unrated_trip.rating = new_rating
    unrated_trip.save

    redirect_to passenger_path(params[:passenger_id])
  end
end
