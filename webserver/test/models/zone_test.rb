# == Schema Information
#
# Table name: zones
#
#  id          :integer          not null, primary key
#  zone        :text(65535)
#  zone_number :integer
#  price       :float(24)
#  payment_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ZoneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
