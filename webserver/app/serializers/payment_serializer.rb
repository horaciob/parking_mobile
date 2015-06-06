# == Schema Information
#
# Table name: payments
#
#  id             :integer          not null, primary key
#  payment_method :string(255)
#  data           :string(255)
#  parking_id     :integer
#  device_id      :integer
#  status         :string(255)
#  price          :float(24)
#  units          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :payment_method, :data, :parking_id, :device_id, :status,:price, :units, :created_at, :updated_at
end

