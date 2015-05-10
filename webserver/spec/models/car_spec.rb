# == Schema Information
#
# Table name: cars
#
#  id            :integer          not null, primary key
#  license_plate :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '#validators' do
    context 'Valid Plates' do
      it 'validates current Argentinian plate' do
        expect(Car.new(license_plate: 'AAA000')).to be_valid
      end
    end
    context 'Not valid' do
      it 'AAAA00 should not be valid' do
        expect(Car.new(license_plate: 'AAAA00')).not_to be_valid
      end

      it '0A0A0A should not be allowed' do
        expect(Car.new(license_plate: '0A0A0A')).not_to be_valid
      end

      it '00AA00 should not be allowed' do
        expect(Car.new(license_plate: '00AA00')).not_to be_valid
      end

      it 'AAA1234 should not be allowed' do
        expect(Car.new(license_plate: 'AAA1234')).not_to be_valid
      end

      it 'empty license_plate should not be allowed' do
        expect(Car.new(license_plate: '')).not_to be_valid
      end
    end
  end
end
