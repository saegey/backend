class Mediators::UserSignup < Mediators::Base
  def initialize(args)
    @args = args
  end

  def call
    account = Account.new
    account.save

    user = User.new
    user.provider = @args[:provider]
    user.provider_id = @args[:uid]
    user.account = account

    account.user = user
    account.save
    
    if user.valid?
      user.save
      serialize(user)
    else
      user.errors
    end
  end

  private

  def serialize(data, structure = :default)
    Serializers::User.new(structure).serialize(data)
  end
end
