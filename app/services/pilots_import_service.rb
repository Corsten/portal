module PilotsImportService
  # rubocop:disable Metrics/AbcSize
  module_function

  LEADER_STATE = {
    'Да' => 'yes',
    'Нет' => 'no',
    'Не оценивалось' => 'unknown'
  }.freeze

  STATUS = {
    'Пилот завершен' => 'completed',
    'Пилот еще идет' => 'in_process',
    'Решение внедрено' => 'implemented'
  }.freeze

  def import(data = {})
    spreadsheet = Roo::Spreadsheet.open(data[:document], extension: :xlsx)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row_keys = row.keys
      row[row_keys[1]]&.sub!('_', ' ')

      category = Category.find_by(name: row[row_keys[1]])
      group = category.groups.find_by(name: row[row_keys[2]]) unless category.nil?

      next if category.nil? || group.nil?

      attrs = {
        customer_name: row[row_keys[3]],
        supplier_name: row[row_keys[4]],
        software_name: row[row_keys[5]],
        manufacturer_name: row[row_keys[6]],
        in_rsr: row[row_keys[7]],
        registry_link: row[row_keys[8]],
        leader_state: LEADER_STATE[row[row_keys[9]]],
        unfunctional_requirements: row[row_keys[11]],
        functional_requirements: row[row_keys[10]],
        status: STATUS[row[row_keys[12]]],
        result: row[row_keys[13]],
        notes: row[row_keys[14]],
        manufacturer_link: row[row_keys[15]],
        customer_link: row[row_keys[16]]
      }
      pilot = group.pilots.new(attrs)
      pilot.save
    end
  end
  # rubocop:enable Metrics/AbcSize
end
