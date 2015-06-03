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
    payment_method 'test'
  end


  factory :payment1, class: Payment do
    data '{"data1":"value1"}'
    price 30
    units 90
    payment_method 'test'
    status 'accepted'

    trait :credit_card do
      payment_method 'credit_card'
    end

    trait :low_price do
      price 1
    end

    trait :low_units do
      units 1
    end
    trait :pending do
      status 'pending'
    end
  end


  factory :payment2 do
    data '{"data1":"value1"}'
    price 30
    units 90
  end
end
