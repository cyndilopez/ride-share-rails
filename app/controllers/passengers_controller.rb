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
