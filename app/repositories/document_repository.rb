module DocumentRepository
  extend ActiveSupport::Concern

  included do
    scope :for_main_page, -> { where(show_in_main_page: true) }
    scope :pilot_template, -> { where(kind: :pilot_template).limit('1') }
  end
end
