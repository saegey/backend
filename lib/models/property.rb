class Property < Sequel::Model
  one_to_many :property_units
  plugin :validation_helpers
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence [:name, :account_id]
  end
end
