# == Schema Information
#
# Table name: cars
#
#  id            :integer          not null, primary key
#  license_plate :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :car do
    license_plate  'AAA123'
  end

  factory :car_test, class: Car do
    license_plate  'ABC123'
  end

  factory :car_test1, class: Car do
    license_plate  'BCA321'
  end
end

