class PhoneValidator < ActiveModel::EachValidator
  PHONE_MASK = /\+[0-9]\s[0-9]{3}\s[0-9]{3}-[0-9]{2}-[0-9]{2}/

  def validate_each(record, attribute, value)
    record.errors.add(attribute, :phone_number) if value.present? && value !~ PHONE_MASK
  end
end
