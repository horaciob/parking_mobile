class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :payment_method
      t.string :data
      t.integer :parking_id
      t.integer :device_id
      t.string :status, default: 'pending'
      t.float :price
      t.timestamps null: false
    end
  end
end
