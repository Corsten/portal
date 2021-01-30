class CustomPasswordValidator < ActiveModel::EachValidator
  MIN_PASSWORD_LENGTH = 8
  PASSWORD_MASK = /((?: (?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.{#{MIN_PASSWORD_LENGTH},})))/x

  def validate_each(record, attribute, value)
    record.errors.add(attribute, :must_not_contains_email) if value.present? && record.email.present? && value =~ /#{record.email}/i
    record.errors.add(attribute, :must_minimum_length, length: MIN_PASSWORD_LENGTH) if value.present? && value.size < MIN_PASSWORD_LENGTH
    record.errors.add(attribute, :must_contains_symbols) if value.present? && value !~ PASSWORD_MASK
  end
end
