require "sequel"
require "./conf/init_db.rb"

Sequel.extension :migration

Sequel.migration do
  up do
    create_table(:cars) do
      primary_key :id
      String :registration, null: false
      String :model, null: true
    end
  end

  down do
    drop_table(:cars)
  end
end
