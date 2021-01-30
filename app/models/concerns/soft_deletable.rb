module Concerns
  module SoftDeletable
    extend ActiveSupport::Concern

    included do
      state_machine initial: :blocked do
        state :actual
        state :blocked
        state :deleted

        event :block do
          transition actual: :blocked
        end

        event :unblock do
          transition blocked: :actual
        end

        event :mark_as_deleted do
          transition %i[actual blocked] => :deleted
        end
      end

      scope :active, -> { where(state: %i[actual blocked]) }
      scope :actual, -> { with_state(:actual) }
    end
  end
end
