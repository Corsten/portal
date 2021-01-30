class EventDecorator < ApplicationDecorator
  decorates :event

  def date
    object.date.present? ? I18n.l(object.date, format: :only_date) : object.date
  end

  def time
    object.time.present? ? I18n.l(object.time, format: :only_time) : object.time
  end
end
