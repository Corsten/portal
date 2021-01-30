class Reporters::MapReporter < Reporters::Base
  include Reporters::AutoColumns

  I18N_SCOPE = 'reports.columns'.freeze

  add_column(:category_name, width: 20, title: I18n.t('category_name', scope: I18N_SCOPE))
  add_column(:group_name, width: 20, title: I18n.t('group_name', scope: I18N_SCOPE))
  add_column(:name, width: 20, title: I18n.t('name', scope: I18N_SCOPE))
  add_column(:manufacturer, width: 20, title: I18n.t('manufacturer', scope: I18N_SCOPE))
  add_column(:link, width: 20, title: I18n.t('link', scope: I18N_SCOPE))
  add_column(:document_link, width: 20, title: I18n.t('document_link', scope: I18N_SCOPE))

  def report_file_name
    'map.xlsx'
  end

  def title(count, date)
    I18n.t('reports.titles.map_report', count: count, date: date)
  end

  def heights
    { title: 40, head: 40 }
  end
end
