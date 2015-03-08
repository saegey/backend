Sequel.migration do
  up do
  	add_column :property_units, :phone_number, String
  end

  down do
  	drop_column :property_units, :phone_number
  end
end
