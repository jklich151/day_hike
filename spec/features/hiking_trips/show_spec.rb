require 'rails_helper'

RSpec.describe "Hiking Trips Show Page" do
  it "can see a list of all trails" do
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

    visit trip_path(trip_1)

    expect(page).to have_content(trail_1.name)
    expect(page).to have_content(trail_1.length)
    expect(page).to have_content(trail_1.address)
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content(trail_2.length)
    expect(page).to have_content(trail_2.address)
    expect(page).to_not have_content(trail_3.name)
    expect(page).to_not have_content(trail_3.length)
    expect(page).to_not have_content(trail_3.address)
  end

  it "can see the total length of all trails on that trip" do
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

    visit trip_path(trip_1)

    expect(page).to have_content("Total Distance:4")
  end

  it "can see the average distance of hikes" do
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

    visit trip_path(trip_1)

    expect(page).to have_content("Average Distance:2")
  end

  it "can see a heading, name and length for longest trail on that trip" do
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

    visit trip_path(trip_1)

    within "#longest-#{trip_1.id}" do
      expect(page).to have_content("Longest Trail on Trip")
      expect(page).to have_content(trail_2.name)
      expect(page).to have_content(trail_2.length)
    end
  end

  it "can see a heading, name and length for shortest trail on that trip" do
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

    visit trip_path(trip_1)

    within "#shortest-#{trip_1.id}" do
      expect(page).to have_content("Shortest Trail on Trip")
      expect(page).to have_content(trail_1.name)
      expect(page).to have_content(trail_1.length)
    end
  end

  it "can see a link to a trail's show page" do
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

    visit trip_path(trip_1)

    click_link "Trail 2"

    expect(current_path).to eq(trail_path(trail_2))
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content(trail_2.length)
    expect(page).to have_content(trail_2.address)
  end

  it "can see a link next to each trail to remove the trail" do
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
    trip_1.trails << trail_3

    visit trip_path(trip_1)

    within "#trail-#{trail_1.id}" do
      click_link "Delete Trail"
    end

    expect(current_path).to eq(trip_path(trip_1))
    expect(page).to_not have_content(trail_1.name)
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content(trail_3.name)
  end
end
