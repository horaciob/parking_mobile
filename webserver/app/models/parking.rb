# == Schema Information
#
# Table name: parkings
#
#  id            :integer          not null, primary key
#  expires_at    :datetime
#  status        :string(255)
#  parking_units :integer
#  device_id     :integer
#  zone_id       :integer
#  car_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

## Estacionamiento medido
class Parking < ActiveRecord::Base
  include Filterable
  has_many :payments
  belongs_to :device
  belongs_to :zone
  belongs_to :car
  accepts_nested_attributes_for :payments, :car, :device

  scope :status, -> (status) { where('status = ?', status) }
  scope :expires, -> (init, finish) { where('expires_at > ? and expires_at < ?', init, finish) }
  scope :license_plate, -> (license_plate) { joins(:car).where('license_plate = ?', license_plate) }
  scope :zone_name, -> (zone_name) { joins(:zone).where('name = ?', zone_name) }
  scope :zone_number, -> (zone_number) { joins(:zone).where('number = ?', zone_number) }

  validates :parking_units, presence: true
  validates :device, presence: true
  validates :car, presence: true
  validates :zone, presence: true

  after_create :calulate_expiration

  def calulate_expiration
    finish = created_at + (zone.unit_time * 60 * parking_units)
    update_attributes(expires_at: finish)
  end

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
