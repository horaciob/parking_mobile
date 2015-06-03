require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    before(:each) do
      FactoryGirl.create_list(:payment1, 3)
    end

    it 'list all payments' do
      get :index
      expect(JSON.parse(response.body).size).to eq 3
    end

    it 'return 200 when list' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'filter by payment_method' do
      3.times { FactoryGirl.create(:payment1, :credit_card) }
      get :index, payment_method: 'credit_card'
      expect(JSON.parse(response.body).size).to eq 3
    end

    it 'filter by price' do
      3.times { FactoryGirl.create(:payment1, :low_price) }
      get :index, price: 1
      expect(JSON.parse(response.body).size).to eq 3
    end

    it 'filter by units' do
      3.times { FactoryGirl.create(:payment1, :low_price) }
      get :index, price: 1
      expect(JSON.parse(response.body).size).to eq 3
    end

    it 'filter by units' do
      3.times { FactoryGirl.create(:payment1, :low_units) }
      get :index, units: 1
      expect(JSON.parse(response.body).size).to eq 3
    end

    it 'filter by status' do
      3.times { FactoryGirl.create(:payment1, :pending) }
      get :index, status: 'pending'
      expect(JSON.parse(response.body).size).to eq 3
    end

    it 'filter by create_after'
    it 'filter by create_before'
  end

  describe '#show' do
    let(:payment) { FactoryGirl.create(:payment) }

    it 'returns 200 when exist' do
      get :show, id: payment.id
      expect(response).to have_http_status(200)
    end

    it 'returns payments if exist' do
      get :show, id: payment.id
      expect(JSON.parse(response.body).keys).to include('payment_method', 'data', 'parking_id',
                                                        'device_id', 'status', 'price', 'units',
                                                        'id', 'created_at', 'updated_at')
    end

    it 'returns 404 if not exist' do
      get :show, id: 987
      expect(response).to have_http_status(404)
    end
  end
end
