require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create name: "sample name", vin: "SOME VIN"
  }
  let (:passenger) {
    Passenger.create name: "sample name", phone_num: "(555) 555-5555"
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
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
