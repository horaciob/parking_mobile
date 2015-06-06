# == Schema Information
#
# Table name: parkings
#
#  id            :integer          not null, primary key
#  expires_at    :datetime
#  status        :string(255)      default("pending")
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

  context '#Scopes' do
    it 'filters by status allowed' do
      3.times { FactoryGirl.create(:parking, :expired) }
      2.times { FactoryGirl.create(:parking, :allowed) }
      expect(Parking.status('allowed').size).to eq 2
    end

    it 'filters by status expired' do
      6.times { FactoryGirl.create(:parking, :expired) }
      3.times { FactoryGirl.create(:parking, :allowed) }
      expect(Parking.status('expired').size).to eq 6
    end

    it 'filter by expires_at field'

    it 'filter by license plate' do
      3.times { FactoryGirl.create(:parking) }
      2.times { FactoryGirl.create(:parking, :car_test) }
      expect(Parking.license_plate('ABC123').size).to eq 2
    end

    it 'filter by zone number' do
      3.times { FactoryGirl.create(:parking) }
      2.times { FactoryGirl.create(:parking, :zone_test) }
      expect(Parking.zone_number('300').size).to eq 3
    end

    it 'filter by zone name' do
      3.times { FactoryGirl.create(:parking) }
      2.times { FactoryGirl.create(:parking, :zone_test) }
      expect(Parking.zone_name('catamarca').size).to eq 2
    end
  end

  describe 'expirations' do
    it 'expired? respnds true if it expires' do
      parking = FactoryGirl.create(:parking, :expired)
      expect(parking.expired?).to eq(true)
    end

    it 'expires? respond false if not expired' do
      parking = FactoryGirl.create(:parking)
      expect(parking.expired?).to eq(false)
    end
  end
end
