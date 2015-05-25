# == Schema Information
#
# Table name: devices
#
#  id                 :integer          not null, primary key
#  notification_token :string(500)
#  user_agent         :string(255)
#  car_id             :integer
#  parking_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:params) do
    { notification_token: 'abcdefg12345678',
      user_agent: 'test_user_agent',
      car: FactoryGirl.build(:car) }
  end

  describe '#create' do
    it 'allows to create new device' do
      device = Device.new(params)
      expect(device.save).to eq(true)
    end
  end

  describe '#validations' do
    it 'validates presence of notification token' do
      values = params
      values.delete :notification_token
      device = Device.new(values)
      device.valid?
      expect(device.errors[:notification_token]).to include("can't be blank")
    end

    it 'validates presence of car' do
      values = params
      values.delete :car
      device = Device.new(values)
      device.valid?
      expect(device.errors[:car]).to include("can't be blank")
    end

    it 'validates precense of user agent' do
      values = params
      values.delete :user_agent
      device = Device.new(values)
      device.valid?
      expect(device.errors[:user_agent]).to include("can't be blank")
    end
  end
end
