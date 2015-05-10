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
end
