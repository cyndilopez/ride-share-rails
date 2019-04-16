class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    unless @driver
      redirect_to drivers_path
      return
    end
    @trips = @driver.trips
  end

  def new
    @driver = Driver.new
  end

  def create
    driver = Driver.new driver_params
    driver.save
    redirect_to drivers_path
  end

  def edit
  end

  def destroy
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
