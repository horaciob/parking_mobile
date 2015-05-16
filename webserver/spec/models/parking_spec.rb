# == Schema Information
#
# Table name: parkings
#
#  id         :integer          not null, primary key
#  expires_at :datetime
#  status     :string(255)
#  car_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Parking, type: :model do
  #let(parking){Parking.new}
  context '#validation' do
  end
  context '#status' do
    describe 'expired?' do

    end
    describe 'need_to_be_expired?' do
      it 'true if expired' do
        #user = FactoryGirl.create :parking
      end
    end
  end
end
