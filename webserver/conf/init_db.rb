require "sequel"

puts "Creating databases"

DB = Sequel.connect(:adapter=>'mysql2',
                    :host=>'localhost',
                    :database=>'traffic_api',
                    :user=>'root',
                    :password=>'Bender')
