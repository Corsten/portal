class Reporters::PilotReporter < Reporters::Base
  include Reporters::AutoColumns

  I18N_SCOPE = 'reports.columns'.freeze

  add_column(:category_name, width: 20, title: I18n.t('category_name', scope: I18N_SCOPE))
  add_column(:group_name, width: 20, title: I18n.t('group_name', scope: I18N_SCOPE))
  add_column(:customer_name, width: 20, title: I18n.t('customer_name', scope: I18N_SCOPE))
  add_column(:supplier_name, width: 20, title: I18n.t('supplier_name', scope: I18N_SCOPE))
  add_column(:software_name, width: 20, title: I18n.t('software_name', scope: I18N_SCOPE))
  add_column(:manufacturer_name, width: 20, title: I18n.t('manufacturer_name', scope: I18N_SCOPE))
  add_column(:in_rsr, width: 10, title: I18n.t('in_rsr', scope: I18N_SCOPE))
  add_column(:registry_link, width: 20, title: I18n.t('registry_link', scope: I18N_SCOPE))
  add_column(:leader_state, width: 20, title: I18n.t('leader_state', scope: I18N_SCOPE))
  add_column(:unfunctional_requirements, width: 20, title: I18n.t('unfunctional_requirements', scope: I18N_SCOPE))
  add_column(:functional_requirements, width: 20, title: I18n.t('functional_requirements', scope: I18N_SCOPE))
  add_column(:status, width: 20, title: I18n.t('status', scope: I18N_SCOPE))
  add_column(:result, width: 20, title: I18n.t('result', scope: I18N_SCOPE))
  add_column(:notes, width: 20, title: I18n.t('notes', scope: I18N_SCOPE))
  add_column(:manufacturer_link, width: 20, title: I18n.t('manufacturer_link', scope: I18N_SCOPE))
  add_column(:customer_link, width: 20, title: I18n.t('customer_link', scope: I18N_SCOPE))

  def report_file_name
    'pilots.xlsx'
  end

  def title(count, date)
    I18n.t('reports.titles.pilots_report', count: count, date: date)
  end

  def heights
    { title: 40, head: 40 }
  end
end
