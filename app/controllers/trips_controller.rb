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
    driver = Driver.all.sample
    @trip.driver_id = driver.id
    puts "driverr_id = #{driver.id}"
    @trip.date = Date.today
    # passenger_id = 1
    passenger_id = params[:id]
    puts "passenger_is = #{passenger_id}"
    @trip.passenger_id = passenger_id
    @trip.save
    @trip.errors.messages.each do |column, problem_list|
      problem_list.each do |problem|
        puts "#{column} : #{problem}"
      end
    end

    redirect_to passenger_path(1)
  end

  # @trip.cost
end
