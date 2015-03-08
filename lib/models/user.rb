class User < Sequel::Model
  include Shield::Model	
  plugin :validation_helpers

  many_to_one :account

  def self.fetch(email)
    first(email: email)
  end

  def before_create
    super
    if self.account_id == nil
      account = Account.create(status: 'pending')
      self.account_id = account.id
    end
  end

  def after_create
    account = Account.first(id: self.account_id)
    account.user_id = self.id
    account.save
  end

  def before_save
    super
    if self.email.nil? || self.first_name.nil? || self.last_name.nil?
      self.status = 'pending'
    else
      self.status = 'active'
    end
  end

  def validate
    super
    if self.email
      validates_format /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :email
      validates_unique :email
    end
  end
end
