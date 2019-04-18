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
          vin: "some vin",
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

    it "validates parameters correctly" do
      driver.name = nil
      expect(driver.save).must_equal false
      expect(driver.valid?).must_equal false
      expect(driver.errors.messages[:name][0]).must_equal "can't be blank"
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

    it "validates parameters correctly" do
      driver = Driver.new
      expect(driver.valid?).must_equal false
      expect(driver.errors.messages[:name][0]).must_equal "can't be blank"
      expect(driver.errors.messages[:vin][0]).must_equal "can't be blank"
    end
  end

  describe "destroy" do
    # before { get  drivers_path}

    it "removes the driver from the database" do
      driver_to_delete = Driver.create!(name: "delete", vin: "vin to delete")
      # driver_to_delete.save
      # delete driver_path(driver_to_delete)
      # delete driver_path(driver)
      # p Driver.count
      # p Driver.find(driver_to_delete.id)
      expect {
        delete driver_path(driver_to_delete)
      }.must_change "Driver.count", -1
      must_respond_with :redirect
      must_redirect_to drivers_path

      after_delete_driver = Driver.find_by(id: driver_to_delete.id)
      expect(after_delete_driver).must_be_nil
    end
  end
end
