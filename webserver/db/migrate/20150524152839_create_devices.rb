class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :notification_token, limit: 500
      t.string :user_agent, limit: 500
      t.integer :car_id

      t.timestamps null: false
    end
  end
end
