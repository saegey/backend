class Mediators::UserSignup < Mediators::Base
  def initialize(args)
    @args = args
  end

  def call
    user = User.new
    user.provider = @args[:provider]
    user.provider_id = @args[:uid]
    
    if user.valid?
      user.save
      user
    else
      user.errors
    end
  end

  private

  def serialize(data, structure = :default)
    Serializers::User.new(structure).serialize(data)
  end
end
