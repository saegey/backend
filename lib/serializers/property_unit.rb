class Serializers::PropertyUnit < Serializers::Base
  structure(:default) do |arg|
    {
      created_at:   arg.created_at.try(:iso8601),
      id:           arg.id,
      updated_at:   arg.updated_at.try(:iso8601),
      property_id:  arg.property_id,
      phone_number: arg.phone_number
    }
  end

    structure(:nested) do |arg|
    {
      id:           arg.id,
      phone_number: arg.phone_number,
      created_at:   arg.created_at.try(:iso8601),
      updated_at:   arg.updated_at.try(:iso8601),
      phone_number: arg.phone_number
    }
  end
end
