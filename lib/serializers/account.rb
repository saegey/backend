class Serializers::Account < Serializers::Base
  structure(:default) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.uuid,
      updated_at: arg.updated_at.try(:iso8601),
      properties: arg.properties,
    }
  end
end
