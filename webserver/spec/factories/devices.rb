# == Schema Information
#
# Table name: devices
#
#  id                 :integer          not null, primary key
#  notification_token :string(500)
#  user_agent         :string(255)
#  car_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :device do
    notification_token 'fasdfadsfdas312312'
    user_agent 'agent/test 5.0'
    car_id 1
    parking_id 1
  end
end
