# == Schema Information
#
# Table name: parkings
#
#  id            :integer          not null, primary key
#  expires_at    :datetime
#  status        :string(255)      default("allowed")
#  parking_units :integer
#  device_id     :integer
#  zone_id       :integer
#  car_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Parking controller
class ParkingSerializer < ActiveModel::Serializer
  attributes :id, :expires_at, :formated_expires_at, :status, :parking_units, :device, :zone,
             :created_at, :updated_at, :zone, :payments, :car
  def formated_expires_at
    (expires_at-3*60*60).strftime("%d/%m %H:%M")
  end

  def device
    object.device
  end

  def zone
    object.zone
  end

  def payments
    object.payments
  end

  def car
    object.car
  end
end
