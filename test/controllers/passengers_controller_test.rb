require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample task", phone_num: "(555) 555-5555"
  }
  describe "index" do
    it "can get the index" do
      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "Can get a passenger with a valid id" do
      get passenger_path(passenger.id)

      must_respond_with :ok
    end

    it "Will redirect if given an invalid Passenger ID" do
      get passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)
      must_respond_with :success
    end

    it "will respond with a redirect when attempting to edit a nonexistent passenger" do
      get edit_passenger_path(-1)
      must_redirect_to passengers_path
    end  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    it "can get the new driver page" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_num: "123-456-7890",
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
