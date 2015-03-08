class PropertyUnit < Sequel::Model
  many_to_one :property
  many_to_one :account
  plugin :timestamps
  plugin :validation_helpers

  def validate
    super
    # validates_presence [:pin_code]
  end

  # def before_save
  #   self.pin_code = Random.rand(1000...9999)
  #   super
  # end
end
