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
    @trip.cost = Trip.calc_cost
    passenger_id = params[:passenger_id]
    @trip.passenger_id = passenger_id
    @trip.save

    redirect_to passenger_path(passenger_id)
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    unless @trip
      redirect_to root_path
      return
    end
    if params[:rating]
      new_rating = params[:rating]
    else
      new_rating = params[:trip][:rating]
      new_cost = params[:trip][:cost]

      @trip.cost = new_cost
    end
    @trip.rating = new_rating
    successful = @trip.save
    if successful
      redirect_to trip_path(@trip)
    else
      render :edit
    end
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
