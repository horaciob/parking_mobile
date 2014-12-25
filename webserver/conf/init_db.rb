require "sequel
"
DB = Sequel.connect(:adapter=>'mysql2',
                    :host=>'localhost',
                    :database=>'trafficApi',
                    :user=>'root',
                    :password=>'Bender')
DB << "SET CLIENT_ENCODING TO 'UTF8';"

