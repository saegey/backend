require 'sequel/plugins/serialization'

class Property < Sequel::Model
  one_to_many :property_units
  many_to_one :account
  plugin      :validation_helpers
  plugin      :timestamps, update_on_create: true
  plugin      :serialization, :json, :outbound_phone_numbers
  
  def validate
    super
    validates_presence [:name, :account_id]
  end
end
