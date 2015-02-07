class Serializers::Property < Serializers::Base
  structure(:default) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.id,
      name:       arg.name,
      updated_at: arg.updated_at.try(:iso8601),
      units:      Serializers::PropertyUnit.new(:nested).serialize(arg.property_units),
    }
  end
end
