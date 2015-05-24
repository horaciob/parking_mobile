# == Schema Information
#
# Table name: devices
#
#  id                 :integer          not null, primary key
#  notification_token :string(500)
#  user_agent         :string(255)
#  car_id             :integer
#  parking_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
