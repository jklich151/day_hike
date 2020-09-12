require 'rails_helper'

describe Trail, type: :model do
  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }

    it { should validate_numericality_of(:length).only_integer }
    it { should validate_numericality_of(:length).is_greater_than(0) }
  end

  describe "relationships" do
    it {should have_many :trail_trips}
    it {should have_many(:trips).through(:trail_trips)}
  end

  describe "instance methods" do
    it "#all_trips" do
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

      expect(trail_1.all_trips).to eq(3)
    end
  end
end
