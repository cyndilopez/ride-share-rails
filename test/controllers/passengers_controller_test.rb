require "test_helper"

describe PassengersController do
  describe "index" do
    it "can get the index" do
      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

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
