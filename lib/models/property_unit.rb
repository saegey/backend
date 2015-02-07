class PropertyUnit < Sequel::Model
  many_to_one :property
  plugin :timestamps
end
