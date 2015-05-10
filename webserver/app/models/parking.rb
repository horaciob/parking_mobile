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

## Estacionamiento medido
class Parking < ActiveRecord::Base
  has_many :payment
  belongs_to :zone
  belongs_to :car
end
