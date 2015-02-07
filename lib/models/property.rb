class Property < Sequel::Model
  one_to_many :property_units
  plugin :validation_helpers
  plugin :timestamps

  def validate
    super
    validates_presence [:name, :account_id]
  end
end
