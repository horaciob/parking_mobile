# == Schema Information
#
# Table name: payments
#
#  id             :integer          not null, primary key
#  payment_method :string(255)
#  data           :string(255)
#  parking_id     :integer
#  device_id      :integer
#  status         :string(255)
#  price          :float(24)
#  units          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :payment do
    data '{"data1":"value1"}'
    price 30
    units 90
  end

  factory :payment2 do
    data '{"data1":"value1"}'
    price 30
    units 90
  end
end
