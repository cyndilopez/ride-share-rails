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
    @trip = Trip.new
    @trips = @passenger.trips
  end

  def new
    @passenger = Passenger.new
  end

  def create_trip
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

    redirect_to passenger_path(passenger_id)
  end

  def create
    passenger = Passenger.new passenger_params
    passenger.save
    redirect_to passengers_path
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
