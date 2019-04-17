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
    @unrated_trip = @passenger.trips.find_by(rating: nil)
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

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger
      redirect_to passengers_path
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger
      redirect_to passengers_path
      return
    end
    @passenger.update(passenger_params)
    redirect_to passenger_path(@passenger)
  end

  def destroy
    p "in here"
    passenger = Passenger.find_by(id: params[:id])
    unless passenger
      head :not_found
      return
    end
    passenger.destroy
    redirect_to passengers_path
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
