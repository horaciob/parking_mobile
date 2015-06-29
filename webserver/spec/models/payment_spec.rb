# == Schema Information
#
# Table name: payments
#
#  id             :integer          not null, primary key
#  payment_method :string(255)
#  data           :string(255)
#  parking_id     :integer
#  device_id      :integer
#  status         :string(255)      default("pending")
#  price          :float(24)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Payment, type: :model do

  describe '#create' do
    let(:params) do
      {
        payment_method: 'test',
        data: '{"key", "value"}',
        price: 100
      }
    end
    it 'Creates a new payment' do
      parking = FactoryGirl.create(:parking)
      @p = Payment.new(params)
      @p.parking = parking
      expect(@p.save).to eq(true)
    end
  end
end
