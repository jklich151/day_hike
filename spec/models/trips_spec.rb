require 'rails_helper'

RSpec.describe Trip do
  describe "relationships" do
    it {should have_many :trail_trips}
    it {should have_many(:trails).through(:trail_trips)}
    it {should belong_to :visitor}
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "instance methods" do
    it "#total_distance" do
      trip_1 = Trip.create(name: "Sunny Hike")
      trip_2 = Trip.create(name: "Rainy Hike")
      visitor_1 = Visitor.create(name: "Jenny")
      trail_1 = Trail.create!(name: "Trail 1",
                              length: 1,
                              address: "Colorado")
      trail_2 = Trail.create!(name: "Trail 2",
                              length: 3,
                              address: "Utah")
      trail_3 = Trail.create!(name: "Trail 3",
                              length: 4,
                              address: "Arizona")

      visitor_1.trips << trip_1
      visitor_1.trips << trip_2
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_2.trails << trail_3

      expect(trip_1.total_distance).to eq(4)
    end

    it "#average_distance" do
      trip_1 = Trip.create(name: "Sunny Hike")
      trip_2 = Trip.create(name: "Rainy Hike")
      visitor_1 = Visitor.create(name: "Jenny")
      trail_1 = Trail.create!(name: "Trail 1",
                              length: 1,
                              address: "Colorado")
      trail_2 = Trail.create!(name: "Trail 2",
                              length: 3,
                              address: "Utah")
      trail_3 = Trail.create!(name: "Trail 3",
                              length: 6,
                              address: "Arizona")

      visitor_1.trips << trip_1
      visitor_1.trips << trip_2
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_2.trails << trail_3

      expect(trip_1.average_distance).to eq(2)
    end

    it "#longest_trail" do
      trip_1 = Trip.create(name: "Sunny Hike")
      trip_2 = Trip.create(name: "Rainy Hike")
      visitor_1 = Visitor.create(name: "Jenny")
      trail_1 = Trail.create!(name: "Trail 1",
                              length: 1,
                              address: "Colorado")
      trail_2 = Trail.create!(name: "Trail 2",
                              length: 3,
                              address: "Utah")
      trail_3 = Trail.create!(name: "Trail 3",
                              length: 6,
                              address: "Arizona")

      visitor_1.trips << trip_1
      visitor_1.trips << trip_2
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_2.trails << trail_3

      expect(trip_1.longest_trail).to eq(trail_2)
    end

    it "#shortest_trail" do
      trip_1 = Trip.create(name: "Sunny Hike")
      trip_2 = Trip.create(name: "Rainy Hike")
      visitor_1 = Visitor.create(name: "Jenny")
      trail_1 = Trail.create!(name: "Trail 1",
                              length: 1,
                              address: "Colorado")
      trail_2 = Trail.create!(name: "Trail 2",
                              length: 3,
                              address: "Utah")
      trail_3 = Trail.create!(name: "Trail 3",
                              length: 6,
                              address: "Arizona")

      visitor_1.trips << trip_1
      visitor_1.trips << trip_2
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_2.trails << trail_3

      expect(trip_1.shortest_trail).to eq(trail_1)
    end
  end
end
