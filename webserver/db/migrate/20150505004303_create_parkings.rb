class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :licence_plate
      t.integer :zone_id
      t.datetime :finish_at
      t.string :status

      t.timestamps null: false
    end
  end
end
