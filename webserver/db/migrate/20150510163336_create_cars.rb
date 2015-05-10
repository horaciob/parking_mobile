class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :license_plate

      t.timestamps null: false
    end
  end
end
