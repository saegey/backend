class Sequel::Model
  def validates_phone_number(phone_number)
    phone_number = send(phone_number)
    if phone_number.nil? == false
      if phone_number.kind_of?(Array) && phone_number.length > 0
        phone_number.each do |p, k|
          errors.add(:outbound_phone_numbers, "is not valid") if /\+[0-9]{8}/.match(p) == nil
          errors.add(:outbound_phone_numbers, "needs to be 12 characters") if p.length != 12
        end
      else
        errors.add(:phone_number, "is not valid") if /\+[0-9]{8}/.match(phone_number) == nil
        errors.add(:phone_number, "needs to be 12 characters") if phone_number.length != 12
      end
    end
  end
end
