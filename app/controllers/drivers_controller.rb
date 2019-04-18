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
    @driver = Driver.new driver_params
    successful = @driver.save
    if successful
      redirect_to drivers_path
    else
      render :new
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    unless @driver
      redirect_to drivers_path
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    unless @driver
      redirect_to drivers_path
      return
    end
    if @driver.update(driver_params)
      redirect_to driver_path(@driver)
    else
      render :edit
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])
    unless driver
      head :not_found
      return
    end
    driver.destroy
    redirect_to drivers_path
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
