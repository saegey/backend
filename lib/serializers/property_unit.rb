class Serializers::PropertyUnit < Serializers::Base
  structure(:default) do |arg|
    {
      created_at:  arg.created_at.try(:iso8601),
      id:          arg.id,
      updated_at:  arg.updated_at.try(:iso8601),
      property_id: arg.property_id,
      pin_code:    arg.pin_code
    }
  end

    structure(:nested) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.id,
      updated_at: arg.updated_at.try(:iso8601),
      pin_code:   arg.pin_code
    }
  end
end
