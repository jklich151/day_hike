require 'rails_helper'

RSpec.describe Visitor do
  it {should have_many :trips}
end
