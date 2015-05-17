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

require 'test_helper'

class ZoneTest < ActiveSupport::TestCase
  describe '.set_defaults' do
    it 'does set unit_time default' do
      zone = Zone.new
      zone.valid?
      expect(zone.unit_time).not_to be_empty
    end

    it 'does set unit_time default' do
      zone = Zone.new
      zone.valid?
      expect(zone.unit_price).not_to be_empty
    end
  end
end
