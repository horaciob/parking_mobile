# == Schema Information
#
# Table name: parkings
#
#  id            :integer          not null, primary key
#  expires_at    :datetime
#  status        :string(255)
#  parking_units :integer
#  zone_id       :integer
#  car_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

## Estacionamiento medido
class Parking < ActiveRecord::Base
  has_many :payment
  belongs_to :zone
  belongs_to :car
  has_many :devices

  def expiration_check
    update_atrribute(:status, 'expired') if need_to_be_expired?
  end

  def expired?
    status == 'expired'
  end

  private

  def need_to_be_expired?
    !expired? && Time.zone.now > expires_at
  end
end
