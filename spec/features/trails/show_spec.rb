require 'rails_helper'

RSpec.describe "Trails Show Page" do
  it "can see the name and address of the trail" do
    trip_1 = Trip.create(name: "Sunny Hike")
    visitor_1 = Visitor.create(name: "Jenny")
    trail_1 = Trail.create!(name: "Trail 1",
                            length: 1,
                            address: "Colorado")

    visitor_1.trips << trip_1
    trip_1.trails << trail_1

    visit trail_path(trail_1)

    expect(page).to have_content(trail_1.name)
    expect(page).to have_content(trail_1.address)
  end

  it "can see the name and total length of every trip the trail is in" do
    trip_1 = Trip.create(name: "Sunny Hike")
    trip_2 = Trip.create(name: "Rainy Hike")
    trip_3 = Trip.create(name: "Cloudy Hike")
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
    visitor_1.trips << trip_3
    trip_1.trails << trail_1
    trip_1.trails << trail_2
    trip_2.trails << trail_1
    trip_2.trails << trail_3
    trip_3.trails << trail_1
    trip_3.trails << trail_3

    visit trail_path(trail_1)

    expect(page).to have_content(trip_1.name)
    expect(page).to have_content(trip_2.name)
    expect(page).to have_content(trip_3.name)
    expect(page).to have_content(trip_1.total_distance)
    expect(page).to have_content(trip_2.total_distance)
    expect(page).to have_content(trip_3.total_distance)
  end

  it "can see total number of trips this trail is included in" do
    trip_1 = Trip.create(name: "Sunny Hike")
    trip_2 = Trip.create(name: "Rainy Hike")
    trip_3 = Trip.create(name: "Cloudy Hike")
    visitor_1 = Visitor.create(name: "Jenny")
    trail_1 = Trail.create!(name: "Trail 1",
                            length: 1,
                            address: "Colorado")

    visitor_1.trips << trip_1
    visitor_1.trips << trip_2
    visitor_1.trips << trip_3
    trip_1.trails << trail_1
    trip_2.trails << trail_1
    trip_3.trails << trail_1

    visit trail_path(trail_1)

    expect(page).to have_content("Total Trips:3")
  end
end
