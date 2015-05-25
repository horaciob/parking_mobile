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

require 'rails_helper'

RSpec.describe Parking, type: :model do
  context '#creation' do
    let(:params) do
      {
        zone: Zone.first,
        parking_units: 3,
        device_attributes: {
          notification_token: 'fdsafdsafdas',
          user_agent: 'test_agent'
        },
        car_attributes: {
          license_plate: 'AAA123'
        },
        payments_attributes: [{
          payment_method: 'dummy_method',
          data: '{"data":"values"}'
        }]
      }
    end

    it 'is able to create a new Parking and his car' do
      FactoryGirl.create(:zone_catamarca)
      Parking.create(params)
      expect(Car.count).to eq(1)
    end

    it 'is able to create a new Parking and one payment' do
      FactoryGirl.create(:zone_catamarca)
      Parking.create(params)
      expect(Payment.count).to eq(1)
    end

    it 'is able to create a new Parking and his device' do
      FactoryGirl.create(:zone_catamarca)
      Parking.create(params)
      expect(Device.count).to eq(1)
    end

    it 'is able to create a new Parking and all nested attributes' do
      FactoryGirl.create(:zone_catamarca)
      Parking.create(params)
      expect(Car.count).to eq(1)
      expect(Payment.count).to eq(1)
      expect(Device.count).to eq(1)
    end

    it 'is able to create a new Parking and all nested attributes' do
      mock_time = Time.zone.now
      Timecop.freeze(mock_time)
      FactoryGirl.create(:zone_catamarca)
      Parking.create(params)
      expect(Parking.first.expires_at.to_i).to eq((mock_time + 3 * 30 * 60).to_i)
    end
  end

  context '#status' do
    describe 'expired?' do
    end

    describe 'need_to_be_expired?' do
      it 'true if expired' do
      end
    end
  end
end
