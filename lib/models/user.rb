class User < Sequel::Model
  include Shield::Model

  many_to_one :account

  def self.fetch(email)
    first(email: email)
  end

  def before_create
    super
    if !self.account
      self.account = Account.create(status: 'pending')
    end
  end

  def after_create
    if !self.account.user_id
      self.account.user_id = self.id
      self.account.save
    end
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
