class DatetimepickerInput < SimpleForm::Inputs::StringInput
  I18N_SCOPE = 'inputs.datetimepicker'.freeze

  def required_field?
    return options[:required] if options[:required].present?
    false
  end

  def input_html_options
    placeholder = options[:placeholder].nil? ? t(current_id.to_s, scope: I18N_SCOPE) : options[:placeholder]

    super.merge(
      autocomplete: 'off',
      placeholder: placeholder.presence,
      data: { toggle: :datetimepicker, target: "##{current_id}", linked_with: "##{current_id}" },
      value: value,
      timepicker: options[:timepicker]
    )
  end

  def input_html_classes
    super << 'form-control datetimepicker-input datetimepicker' << options[:class]
  end

  def current_id
    "#{@builder.object_name}_#{attribute_name}"
  end

  def value
    date_time = object.send(attribute_name)
    date_time = options[:timepicker] ? date_time&.strftime('%FT%T') : date_time&.iso8601
    date_time = Time.zone.parse(date_time).strftime('%Y%m%d') if date_time && options[:input_html] && options[:input_html][:datepicker]
    date_time
  end
end
