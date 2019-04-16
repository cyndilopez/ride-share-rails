require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample task", phone_num: "(555) 555-5555"
  }
  describe "index" do
    # Your tests go here
  end

  describe "show" do
    it "Can get a task with a valid id" do
      get passenger_path(passenger.id)

      must_respond_with :ok
    end

    it "Will redirect if given an invalid Passenger ID" do
      get passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
