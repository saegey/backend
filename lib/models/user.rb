class User < Sequel::Model
  include Shield::Model	
  plugin :timestamps
  plugin :validation_helpers

  many_to_one :account

  def self.fetch(email)
    user = first(email: email)
    return user
  end

  # def validate
  #   super
  #   validates_presence [:first_name, :last_name, :email]
  # end
end
