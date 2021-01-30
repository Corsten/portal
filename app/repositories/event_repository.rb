module EventRepository
  extend ActiveSupport::Concern

  included do
    scope :scheduled, -> { where(state: :scheduled) }
    scope :not_actual, ->(date) { where('(events.date < :dt)', dt: date) }
  end
end
