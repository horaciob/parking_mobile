# == Schema Information
#
# Table name: cars
#
#  id            :integer          not null, primary key
#  license_plate :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Car model has info about cars
class Car < ActiveRecord::Base
  has_many :parkings

  validates :license_plate, format: { with: /\A[A-ZÑ]{3}\d{3}\z/,
                                      message: 'Patente no valida en la Argentina' },
                            presence: { message: 'Debe incluir la patente del vehiculo' }
end
