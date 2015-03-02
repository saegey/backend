class Serializers::User < Serializers::Base
  structure(:property) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.id,
      name:       arg.name,
      updated_at: arg.updated_at.try(:iso8601)
    }
  end
  structure(:account) do |arg|
    {
      id:         arg.id,
      properties: Serializers::User.new(:property).serialize(arg.properties),
      updated_at: arg.updated_at.try(:iso8601),
      created_at: arg.created_at.try(:iso8601),
    }
  end

  structure(:default) do |arg|
    {
      id:          arg.id,
      first_name:  arg.first_name,
      last_name:   arg.last_name,
      email:       arg.email,
      provider:    arg.provider,
      provider_id: arg.provider_id,
      updated_at:  arg.updated_at.try(:iso8601),
      created_at:  arg.created_at.try(:iso8601),
      status:      arg.status,
      account:     Serializers::User.new(:account).serialize(arg.account),
    }
  end
end

