class EventSerializer < ActiveModel::Serializer
  attributes :date, :time, :state, :place, :description, :name, :topics, :status, :address, :organizer, :id
  def date
    object.date.present? ? I18n.l(object.date, format: :only_date) : object.date
  end

  def time
    object.time.present? ? I18n.l(object.time, format: :only_time) : object.time
  end

  def status
    object.state_text
  end
end
