require 'rails_helper'

RSpec.describe ZonesController, type: :controller do
  describe '#create' do
    context "creating zones" do
      it 'creates new zone' do
        post 'create', :zone => {name: 'testing', zone_number: 400 }
        expect(response).to have_http_status(:ok)
      end
    end

    describe '#modify' do
      subject { creates(:zone) }
      it 'update attributes' do

      end
    end
  end
end
