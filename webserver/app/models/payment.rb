# == Schema Information
#
# Table name: payments
#
#  id             :integer          not null, primary key
#  payment_method :string(255)
#  data           :string(255)
#  parking_id     :integer
#  device_id      :integer
#  status         :string(255)      default("pending")
#  price          :float(24)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

## Payments methods
class Payment < ActiveRecord::Base
  include Filterable

  belongs_to :parking
  belongs_to :zone
  scope :status, -> (status) { where('status = ?', status) }
  scope :price, -> (price) { where('price = ?', price) }
  scope :payment_method, -> (payment_method) { where('payment_method = ?', payment_method) }
  scope :create_after, -> (create_after) { where('created_at > ?', create_after) }
  scope :create_before,  -> (create_before) { where('created_at < ?', create_before) }
end
