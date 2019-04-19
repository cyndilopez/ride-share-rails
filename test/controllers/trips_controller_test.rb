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
    it "can get the edit page for an existing trip" do
      get edit_trip_path(trip)
      must_respond_with :ok
    end
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_trip_path(-1)

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "update" do
    before do
      @trip_data = {
        trip: {
          rating: 5,
        },
      }
    end
    it "changes the data on the model" do

      # Assumptions
      expect(trip.rating).wont_equal @trip_data[:trip][:rating]
      patch trip_path(trip), params: @trip_data

      # Assert
      must_respond_with :redirect
      must_redirect_to trip_path(trip)

      trip.reload
      expect(trip.rating).must_equal(@trip_data[:trip][:rating])
    end

    it "will redirect to the root page if given an invalid id" do
      fake_id = 123456
      expect(Trip.find_by(id: 123456)).must_equal nil

      patch trip_path(fake_id), params: @trip_data

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "Validates the parameters correctly" do
      @trip_data[:trip][:rating] = 0

      trip.assign_attributes(@trip_data[:trip])
      expect(trip).wont_be :valid?
      trip.reload

      patch trip_path(trip), params: @trip_data
      puts
      expect(trip.errors.messages[:rating][0]).must_equal "must be greater than 0"
      must_respond_with :ok
    end
  end

  describe "create" do
    it "can create a new trip from passenger" do
      num_trips = passenger.trips.count

      expect {
        post passenger_trips_path(passenger.id)
      }.must_change "Trip.count", 1

      expect(passenger.trips.count).must_equal num_trips + 1

      must_respond_with :redirect
    end
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
