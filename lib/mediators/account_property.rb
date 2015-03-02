class Mediators::AccountProperty < Mediators::Base
  def initialize(args)
    @args = args
  end

  def call
    return Property.first(
      id: @args[:id],
      account_id: @args[:account_id]
    ) || halt(404)
  end
end
