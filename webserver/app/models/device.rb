# == Schema Information
#
# Table name: devices
#
#  id                 :integer          not null, primary key
#  notification_token :string(500)
#  user_agent         :string(255)
#  car_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Device < ActiveRecord::Base
  include Filterable

  belongs_to :car
  validates :user_agent, presence: true
  validates :notification_token, presence: true
  scope :user_agent, -> (user_agent) { where('user_agent like ?', "%#{user_agent}%") }
  scope :notification_token, -> (notification_token) { where('notification_token = ?', notification_token) }
end
