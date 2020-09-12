require 'rails_helper'

RSpec.describe "Hiking Trips Index Page" do
  it "can see a list of all hiking trip names" do
    trip_1 = Trip.create(name: "Sunny Hike")
    trip_2 = Trip.create(name: "Rainy Hike")
    visitor_1 = Visitor.create(name: "Jenny")

    visitor_1.trips << trip_1
    visitor_1.trips << trip_2

    visit trips_path

    expect(page).to have_content(trip_1.name)
    expect(page).to have_content(trip_2.name)
  end

  it "can see a link that goes to the trips show page" do
    trip_1 = Trip.create(name: "Sunny Hike")
    trip_2 = Trip.create(name: "Rainy Hike")
    visitor_1 = Visitor.create(name: "Jenny")

    visitor_1.trips << trip_1
    visitor_1.trips << trip_2

    visit trips_path

    within "#index-#{trip_1.id}" do
      click_link "Sunny Hike"
    end

    expect(current_path).to eq(trip_path(trip_1))
    expect(page).to have_content("Sunny Hike")
  end
end
