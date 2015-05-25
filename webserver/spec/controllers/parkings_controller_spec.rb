require 'rails_helper'

RSpec.describe ParkingsController, type: :controller do
  describe '#creation' do
    let(:complete_params) do
      {
        parking_units: 3,
        device: {
          notification_token: 'fdsafdsafdas',
          user_agent: 'test_agent'
        },
        zone: {
          name: 'catamarca',
          number: 100
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

    it 'should allow create a parking and his nested attributes' do
      FactoryGirl.create(:zone_catamarca)
      post :create, parking: complete_params
      expect(response).to have_http_status(:ok)
      expect(Cars.count).to eq(1)
      expect(Device.count).to eq(1)
      expect(Payment.count).to eq(1)
    end
  end
end
