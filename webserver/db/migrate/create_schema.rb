require "sequel"

puts "Creating databases"

DB = Sequel.connect(:adapter=>'mysql2',
                    :host=>'localhost',
                    :database=>'traffic_api',
                    :user=>'root',
                    :password=>'Bender')
#DB << "SET CLIENT_ENCODING TO 'UTF8';"

DB.create_table :parkings do
  primary_key :id
  varchar :car_plate
  varchar :status
  varchar :addr
  integer :addr_id
  datetime :created_at
  datetime :expire_at
end
