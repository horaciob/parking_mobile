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

## Una zona es una calle o una agrupacion de estacionamientos
class Zone < ActiveRecord::Base
  has_many :parkings
  before_save :check_price

  validates :zone, presence: true
  validates :zone_number, presence: true
  def check_price
    self.price = 10.0 if price.nil?
  end
end
