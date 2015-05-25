class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.datetime :expires_at
      t.string :status
      t.integer :parking_units
      t.integer :device_id
      t.integer :zone_id
      t.integer :car_id

      t.timestamps null: false
    end
  end
end
