# == Schema Information
#
# Table name: parkings
#
#  id            :integer          not null, primary key
#  expires_at    :datetime
#  status        :string(255)
#  parking_units :integer
#  device_id     :integer
#  zone_id       :integer
#  car_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


FactoryGirl.define do
  factory :parking do
    parking_units 2
    zone
    device
    car
    after :create do |p|
      p.payments << create_list(:payment,2)
    end
    trait :allowed do
      status 'allowed'
      expires_at Time.now + 15 * 60
    end

    trait :expired do
      status 'expired'
      expires_at Time.now - 10 * 60
    end
  end
end
