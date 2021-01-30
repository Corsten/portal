class EventClaimSerializer < ActiveModel::Serializer
  attributes :event_id, :user_id, :state, :state_text

  def state_text
    object.blocked? ? I18n.t('api.errors.confirmation_waiting') : I18n.t('api.errors.success_registration')
  end
end
