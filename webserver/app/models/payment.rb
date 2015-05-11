# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  data       :string(255)
#  parking_id :integer
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

## Payments methods
class Payment < ActiveRecord::Base
  belongs_to :parking

  validates :type, presence: { message: 'Debe especificarse un metodo de pago' }
end
