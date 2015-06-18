# == Schema Information
#
# Table name: payments
#
#  id             :integer          not null, primary key
#  payment_method :string(255)
#  data           :string(255)
#  parking_id     :integer
#  device_id      :integer
#  status         :string(255)      default("pending")
#  price          :float(24)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :payment do
    data '{"data1":"value1"}'
    price 30
    payment_method 'test_method'
  end

  factory :payment1, class: Payment do
    data '{"data1":"value1"}'
    price 30
    payment_method 'test_method'
    status 'accepted'
    created_at Time.now
    updated_at Time.now

    trait :credit_card do
      payment_method 'test_method'
    end

    trait :low_price do
      price 1
    end

    trait :pending do
      status 'pending'
    end

    trait :old do
      created_at Time.now- 60 * 60 * 24
      updated_at Time.now- 60 * 60 * 24
    end
  end

  factory :payment2 do
    data '{"data1":"value1"}'
    price 30
  end
end
