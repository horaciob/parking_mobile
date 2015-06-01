require 'rails_helper'

RSpec.describe ParkingsController, type: :controller do
  let(:complete_params) do
    {
      parking_units: 3,
      device: {
        notification_token: 'fdsafdsafdas',
        user_agent: 'test_agent'
      },
      zone: {
        name: 'catamarca',
        number: 200
      },
      car: {
        license_plate: 'AAA123'
      },
      payment: {
        type: 'dymmy_payment_method',
        data: '{"data","value"}'
      }
    }
  end

  describe '#creation' do
    it 'Allow create a parking and his nested attributes' do
      FactoryGirl.create(:zone_catamarca)
      post :create, parking: complete_params
      expect(response).to have_http_status(:ok)
      expect(Car.count).to eq(1)
      expect(Device.count).to eq(1)
      expect(Payment.count).to eq(1)
    end

    #it 'validates presence of car info on request' do
    #  FactoryGirl.create(:zone_catamarca)
    #  parameters = complete_params
    #  parameters.delete(:car)
    #  post :create, parking: parameters
    #  expect(response).to have_http_status(:unprocessable_entity)
    #end

    it 'Cannot create a parking if zone doesn\'t exist' do
      post :create, parking: complete_params
      expect(response).to have_http_status(404)
    end
  end

  describe '#index' do
    it 'list all parkings'
    it 'list all parkings for a car'
    it 'list filtering by expired date'
  end

  describe '#PUT' do
    it 'extends payments'
    it 'expires'
  end
end
