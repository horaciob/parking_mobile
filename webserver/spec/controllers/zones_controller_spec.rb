require 'rails_helper'

RSpec.describe ZonesController, type: :controller do
  describe '#index' do
    it 'show all zones' do
      FactoryGirl.create_list(:zone, 6)
      get :index
      expect(JSON.parse(response.body).size).to eq 6
    end
  end

  describe '#create' do
    context 'creating zones' do
      it 'creates a new zone' do
        post :create, name: 'testing', number: 800
        expect(Zone.count).to eq 1
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe '#modify' do
    subject { creates(:zone) }
    before(:each) do
      FactoryGirl.create(:zone)
    end

    it 'updates multiple attr' do
      put :update, id: Zone.first.id, name: 'peperino', number: 100, unit_price: 300, unit_time: 1
      expect(response).to have_http_status(200)
    end

    it 'update attribute name' do
      put :update, id: Zone.first.id, zone: { name: 'peperino' }
      expect(response).to have_http_status(200)
    end

    it 'update attribute number' do
      put :update, id: Zone.first.id, zone: { number: 987 }
      expect(response).to have_http_status(200)
    end

    it 'update attribute unit_price' do
      put :update, id: Zone.first.id, zone: { unit_price: 13.12 }
      expect(response).to have_http_status(200)
    end

    it 'update attribute unit_time ' do
      put :update, id: Zone.first.id, zone: { unit_time: 8 }
      expect(response).to have_http_status(200)
    end

    it 'update attribute name' do
      put :update, id: Zone.first.id, zone: { name: 'peperino' }
      expect(response).to have_http_status(200)
    end

    it '404 when zone id isn\'t exist' do
      put :update, id: 900, zone: {}
      expect(response).to have_http_status(404)
    end
  end

  describe '#show' do
    let(:zone) { FactoryGirl.create(:zone) }
    it 'returns zone if its called by name_number' do
      get :show, id:"#{zone.name}-#{zone.number}"
      expect(JSON.parse(response.body)["name"]).to eq(zone.name)
    end

    it 'returns 404 if doesnt exist' do
      get :show, id: 999
      expect(response).to have_http_status 404
    end
    it 'should return zone 200 if zone exist' do
      get :show, id: zone.id
      expect(response).to have_http_status 200
    end

    it 'should return valid zone' do
      get :show, id: zone.id
      expect(JSON.parse(response.body).keys).to include('name', 'number', 'created_at', 'updated_at',
                                                        'unit_time', 'id')
    end

    it 'respond 404 if zone didn\' exist (by name-id)' do
      get :show, id: 'fake-900'
      expect(response).to have_http_status 404
    end

    it 'respond 404 if zone didn\' exist (by id)' do
      get :show, id: 100_000
      expect(response).to have_http_status 404
    end
  end
end
