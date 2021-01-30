namespace :data_migrations do
  desc 'create categories and groups'
  task create_categories_groups: :environment do
    categories = ['Офисное ПО', 'Системное ПО', 'Прикладное ПО', 'Специализированное ПО для информационной и кибербезопасности'].freeze

    groups = {
      'Офисное ПО' => ['Офисный пакет', 'Средства просмотра', 'Браузеры', 'Редакторы,органайзеры', 'Файловые менеджеры',
                       'Антивирусы', 'Поисковые системы', 'Лингвистическое ПО', 'Специализированное пользовательское ПО',
                       'Пользовательское ПО общего назначения', 'Прочее'],
      'Системное ПО' => ['Средства виртуализации', 'СХД', 'СУБД', 'Утилиты и драйверы', 'Операционные системы', 'Системы резервного копирования',
                         'Серверная часть коммуникационных и почтовых приложений', 'Прочее'],
      'Прикладное ПО' => ['Системы PLM', 'Системы BIM', 'СистемыBPM', 'Системы ERP', 'Системы CPM', 'Системы EMP',
                          'Системы CRM, CMS', 'Системы BI, BA и Big dat', 'Системы ITSM SCCM', 'Системы EDMC, ECM',
                          'GIS-системы', 'Прочее'],
      'Специализированное ПО для информационной и кибербезопасности' => ['Межсетевые экраны', 'Средства фильтрации',
                                                                         'Средства выявления целевых атак', 'Средства гарантированного уничтожения данных',
                                                                         'Средства криптографической защиты информациии электронной подписи', 'Прочее']
    }

    categories.each do |category_name|
      cat = Category.create(name: category_name)
      next if groups[category_name].blank?
      groups[category_name].each do |group_name|
        cat.groups.create(name: group_name)
      end
    end
  end
end
