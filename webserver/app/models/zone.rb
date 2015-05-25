# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  number     :integer
#  unit_price :float(24)
#  unit_time  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Zone < ActiveRecord::Base
  has_many :parkings
  has_many :payments
  before_validation :set_defaults
  validates :name, presence: true
  validates :number, presence: true

  def set_defaults
    self.unit_time = DEFAULT_UNIT_TIME.to_i if unit_time.blank?
    self.unit_price = DEFAULT_UNIT_PRICE.to_f if unit_price.blank?
  end
end
