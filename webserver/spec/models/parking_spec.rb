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

require 'rails_helper'

RSpec.describe Parking, type: :model do
end
