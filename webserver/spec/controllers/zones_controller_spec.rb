require 'rails_helper'

RSpec.describe ZonesController, type: :controller do
  describe '#index' do
    it 'show all zones' do
      FactoryGirl.create_list(:zone,6)
      get :index
      expect(JSON.parse(response.body).size).to eq 6
    end
  end

  describe '#create' do
    context 'creating zones' do
      it 'creates a new zone' do
        post :create, {name: 'testing', number: 800}
        expect(Zone.count).to eq 1
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe '#modify' do
    subject { creates(:zone) }

    it 'updates multiple attr' do
      FactoryGirl.create(:zone)
      put :update, id: Zone.first.id, name: 'peperino', number: 100, unit_price: 300, unit_time: 1
      expect(response).to have_http_status(200)
    end

    it 'update attribute name' do
      FactoryGirl.create(:zone)
      put :update, id: Zone.first.id, zone: { name: 'peperino' }
      expect(response).to have_http_status(200)
    end

    it 'update attribute number' do
      FactoryGirl.create(:zone)
      put :update, id: Zone.first.id, zone: { number: 987 }
      expect(response).to have_http_status(200)
    end

    it 'update attribute unit_price' do
      FactoryGirl.create(:zone)
      put :update, id: Zone.first.id, zone: { unit_price: 13.12 }
      expect(response).to have_http_status(200)
    end

    it 'update attribute unit_time ' do
      FactoryGirl.create(:zone)
      put :update, id: Zone.first.id, zone: { unit_time: 8 }
      expect(response).to have_http_status(200)
    end

    it 'update attribute name' do
      FactoryGirl.create(:zone)
      put :update, id: Zone.first.id, zone: { name: 'peperino' }
      expect(response).to have_http_status(200)
    end

    it '404 when zone id isn\'t exist' do
      put :update, id: 900, zone: {}
      expect(response).to have_http_status(404)
    end
  end
end
