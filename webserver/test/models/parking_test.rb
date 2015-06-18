# == Schema Information
#
# Table name: parkings
#
#  id            :integer          not null, primary key
#  expires_at    :datetime
#  status        :string(255)      default("allowed")
#  parking_units :integer
#  device_id     :integer
#  zone_id       :integer
#  car_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
