# == Schema Information
#
# Table name: zones
#
#  id          :integer          not null, primary key
#  zone        :string(255)
#  zone_number :integer
#  unit_price  :float(24)
#  unit_time   :integer
#  payment_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Zone, type: :model do
  context '#Default' do
    it 'Default price should be set' do
      zone = Zone.create(zone: 'test_zone', zone_number: 100)
      zone.reload
      expect(zone.unit_price).to eq(5.0)
    end

    it 'Default time  should be set' do
      zone = Zone.create(zone: 'test_zone', zone_number: 100)
      zone.reload
      expect(zone.unit_time).to eq(30)
    end
  end
end
