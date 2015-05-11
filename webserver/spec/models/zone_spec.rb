# == Schema Information
#
# Table name: zones
#
#  id          :integer          not null, primary key
#  zone        :text(65535)
#  zone_number :integer
#  price       :float(24)
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
      expect(zone.price).to eq(10.0)
    end
  end
end
