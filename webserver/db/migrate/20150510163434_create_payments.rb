class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :type
      t.string :data
      t.integer :parking_id
      t.string :status

      t.timestamps null: false
    end
  end
end