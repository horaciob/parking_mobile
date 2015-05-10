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

require 'rails_helper'

RSpec.describe Payment, type: :model do
end
