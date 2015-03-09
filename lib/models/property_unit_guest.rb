class PropertyUnitGuest < Sequel::Model
  plugin :timestamps
  many_to_one :property_unit
  many_to_one :account
end
