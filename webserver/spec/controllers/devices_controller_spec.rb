require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  describe '#index' do
    it 'shows devices list' do
      FactoryGirl.create_list(:device, 4)
      get :index
      expect(JSON.parse(response.body).size).to eq 4
    end

    it 'filter by token' do
      FactoryGirl.create_list(:device, 4)
      devs = FactoryGirl.create_list(:device_test, 4)
      get :index, notification_token: devs[0].notification_token
      expect(JSON.parse(response.body).size).to eq 4
    end

    it 'filter by user_agent' do
      FactoryGirl.create_list(:device, 4)
      devs = FactoryGirl.create_list(:device_test, 4)
      get :index, user_agent: devs[0].user_agent
      expect(JSON.parse(response.body).size).to eq 4
    end
  end

  describe '#show' do
    it 'shows device by id' do
      FactoryGirl.create_list(:device, 4)
      get :show, id: Device.last.id
      expect(JSON.parse(response.body).keys).to include('notification_token', 'id', 'user_agent',
                                                        'created_at', 'updated_at', 'car_id')
    end

    it 'returns 404 if record is not exist' do
      get :update, id: 987
      expect(response.response_code).to eq(404)
    end
  end

  describe '#update' do
    it 'returns 200 when update is success' do
      dev = FactoryGirl.create(:device)
      put :update, id: dev.id, user_agent: 'testing_changes'
      expect(response.response_code).to eq(200)
    end

    it 'updates values on change' do
      dev = FactoryGirl.create(:device)
      put :update, id: dev.id, user_agent: 'testing_changes'
      dev = Device.first
      expect(dev.user_agent).to eq('testing_changes')
    end

    it 'returns 404 if record is not exist' do
      put :update, id: 987, user_agent: 'testing_changes', notification_token: 'fasdfasd'
      expect(response.response_code).to eq(404)
    end
  end

  describe '#create' do
    it 'creates new device and return 201' do
      post :create, notification_token: 'creation_test', user_agent: 'android/test'
      expect(response.response_code).to eq 201
    end

    it 'creates new device and return a device' do
      post :create, notification_token: 'creation_test', user_agent: 'android/test'
      expect(JSON.parse(response.body).keys).to include('notification_token', 'id', 'user_agent',
                                                        'created_at', 'updated_at', 'car_id')
    end
  end
end
