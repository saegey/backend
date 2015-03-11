class PropertyUnitGuest < Sequel::Model
  many_to_one :property_unit
  many_to_one :account

  def validate
    super
    validates_presence [:account_id, :property_unit_id]
  end
end
