require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create name: "sample name", vin: "SOME VIN"
  }
  let (:passenger) {
    Passenger.create name: "sample name", phone_num: "555-555-5555"
  }
  let (:trip) {
    Trip.create driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 4, cost: 35.5
  }
  describe "show" do
    it "Can get a trip with a valid id" do
      get trip_path(trip.id)

      must_respond_with :ok
    end

    it "Will redirect if given an invalid trip ID" do
      get trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_trip_path(trip)

      # Assert
      must_respond_with :ok
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    it "removes the driver from the database" do
      trip_to_delete = Trip.create!(rating: 3, cost: 123.40, passenger_id: passenger.id, driver_id: driver.id)
      expect {
        delete trip_path(trip_to_delete)
      }.must_change "Trip.count", -1

      must_respond_with :redirect
      must_redirect_to root_path

      after_trip_delete = Trip.find_by(id: trip_to_delete.id)
      expect(after_trip_delete).must_be_nil
    end
  end
end
