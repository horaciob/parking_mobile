class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.text :zone
      t.integer :zone_number
      t.float :price
      t.integer :payment_id

      t.timestamps null: false
    end
  end
end
