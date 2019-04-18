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

  def edit
    @trip = Trip.find_by(id: params[:id])
    unless @trip
      redirect_to root_path
    end
  end

  def create
    @trip = Trip.new
    @trip.driver_id = Driver.find_driver.id
    @trip.date = Date.today

    passenger_id = params[:passenger_id]
    @trip.passenger_id = passenger_id
    @trip.save

    redirect_to passenger_path(passenger_id)
  end

  def update
    unrated_trip = Trip.find_by(id: params[:id])
    unless unrated_trip
      redirect_to root_path
      return
    end
    if unrated_trip.rating.nil?
      new_rating = params[:rating]
    else
      # p params["trip"]["rating"]
      # unrated_trip.update(trip_params)
      new_rating = params["trip"]["rating"]
      # new_rating = params[:rating]
      # unrated_trip.update(rating: params[:rating])
      p params["trip"]["rating"]
    end
    unrated_trip.rating = new_rating
    unrated_trip.save
    # redirect_to passenger_path(params[:passenger_id])
    redirect_to trip_path(unrated_trip)
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    unless trip
      head :not_found
      return
    end
    trip.destroy
    redirect_to root_path
  end

  private

  def trip_params
  end
end
