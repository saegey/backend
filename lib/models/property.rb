require 'sequel/plugins/serialization'

class Property < Sequel::Model
  one_to_many :property_units
  many_to_one :account
  plugin      :serialization, :json, :outbound_phone_numbers

  def validate
    super
    validates_presence [:name, :account_id]
    validates_phone_number :outbound_phone_numbers
  end
end
