class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
  end

  def create
    driver = Driver.new driver_params
    driver.save
    # redirect_to
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
