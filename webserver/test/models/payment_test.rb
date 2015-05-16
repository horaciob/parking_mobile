# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  data       :string(255)
#  parking_id :integer
#  status     :string(255)
#  price      :float(24)
#  units      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
