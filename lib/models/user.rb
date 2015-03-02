class User < Sequel::Model
  include Shield::Model	
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  many_to_one :account

  def self.fetch(email)
    first(email: email)
  end

  def before_create
    if self.account_id == nil
      account = Account.create(status: 'pending')
      self.account_id = account.id
    end
    self.status = 'pending'
    super
  end

  def after_create
    account = Account.first(id: self.account_id)
    account.user_id = self.id
    account.save
  end

  # def validate
  #   super
  #   validates_presence [:first_name, :last_name, :email]
  # end
end
