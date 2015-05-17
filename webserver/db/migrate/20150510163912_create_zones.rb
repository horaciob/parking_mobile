class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.integer :number
      t.float :unit_price
      t.integer :unit_time
      t.timestamps null: false
    end
  end
end
