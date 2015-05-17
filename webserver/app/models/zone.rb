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

## Una zona es una calle o una agrupacion de estacionamientos

class Zone < ActiveRecord::Base
  has_many :parkings
  has_many :payments
  before_validation :set_defaults
  validates :zone, presence: true
  validates :zone_number, presence: true

  def set_defaults
#    self.price = 10.0 if price.nil?
    self.unit_time = DEFAULT_UNIT_TIME.to_i if unit_time.blank?
    self.unit_price = DEFAULT_UNIT_PRICE.to_f if unit_price.blank?
  end

end
