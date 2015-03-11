class Serializers::PropertyUnitGuest < Serializers::Base
  structure(:default) do |arg|
    {
      created_at:   arg.created_at.try(:iso8601),
      id:           arg.id,
      pin_code:     arg.pin_code,
      email:        arg.email,
      phone_number: arg.phone_number,
      expires_at:   arg.expires_at.try(:iso8601),
      updated_at:   arg.updated_at.try(:iso8601),
    }
  end
end
