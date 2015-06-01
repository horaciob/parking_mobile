# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  number     :integer
#  unit_price :float(24)
#  unit_time  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :zone, class: Zone  do
    name 'test'
    number  300
    unit_price 5
    unit_time  30
  end

  factory :zone_test, class: Zone do
    name 'catamarca'
    number 100
    unit_price 5
    unit_time 30
  end

  factory :zone_catamarca, class: Zone do
    name 'catamarca'
    number 200
    unit_price 5
    unit_time 30
  end
end
