# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  number     :integer
#  unit_price :float(24)
#  unit_time  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Zone, type: :model do
  describe '#Default' do
    context 'valid' do
      it 'Default price should be set' do
        zone = Zone.create(name: 'test_zone', number: 100)
        zone.reload
        expect(zone.unit_price).to eq(5.0)
      end

      it 'Default time  should be set' do
        zone = Zone.create(name: 'test_zone', number: 100)
        zone.reload
        expect(zone.unit_time).to eq(30)
      end
    end
  end
end
