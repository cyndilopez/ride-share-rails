require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "sample name", vin: "SOME VIN"
  }

  describe "index" do
    it "can get index" do
      get drivers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "Can get a driver with a valid id" do
      get driver_path(driver.id)

      must_respond_with :ok
    end

    it "Will redirect if given an invalid driver ID" do
      get driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing driver" do
      get edit_driver_path(driver.id)
      must_respond_with :success
    end

    it "will respond with a redirect when attempting to edit a nonexistent driver" do
      get edit_driver_path(-1)
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    before do
      @driver_hash = {
        driver: {
          name: "updated driver",
        },
      }
    end
    it "can update and existing driver" do
      put driver_path(driver.id), params: @driver_hash
      updated_driver = Driver.find_by(name: @driver_hash[:driver][:name])

      must_respond_with :redirect
      must_redirect_to driver_path(updated_driver.id)
    end

    it "will redirect to the root page if given an invalid id" do
      patch driver_path(-1), params: @driver_hash
      must_redirect_to drivers_path
    end
    
    it "will respond with a redirect when fields invalid" do
    end
  end

  describe "new" do
    it "can get the new driver page" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver" do
      driver_hash = {
        driver: {
          name: "new driver", vin: "abcdef123456",
        },
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
    it "will respond with a redirect when fields invalid" do
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
