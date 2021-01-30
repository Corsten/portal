require 'axlsx'

class Reporters::Base
  include Reporters::Helpers

  def initialize(records, export_datetime = Time.current)
    @export_datetime = export_datetime
    prepare_document
    write_document(records)
  end

  def prepare_document
    @package = Axlsx::Package.new
    @package.use_shared_strings = true
    workbook = @package.workbook
    init_styles(workbook)
  end

  def write_document(records)
    @package.workbook.add_worksheet do |sheet|
      merge_title_cells(sheet)
      write_title(sheet, records.count, @export_datetime)
      write_head(sheet)
      write_records(sheet, records)
      after_write_records(sheet, records) if respond_to?(:after_write_records)
    end
  end

  def document
    return unless @package

    @package.to_stream.string
  end

  def write_title(sheet, count, datetime)
    datetime_string = I18n.l(datetime, format: :report)
    title_text = title(count, datetime_string)
    sheet.add_row([title_text], style: workbook_styles[:default], height: heights[:title]) if title_text
  end

  def write_head(sheet)
    sheet.add_row(head, style: workbook_styles[:default], height: heights[:head], widths: widths)
    sheet.add_row(sub_heads.map { |sub_header| sub_header.values.first }, style: workbook_styles[:default], height: heights[:head], widths: widths)
    merge_head_cells(sheet)
    merge_sub_head_cells(sheet)
  end

  def write_records(sheet, records)
    if records.is_a? Array
      records.each do |record|
        row = record_to_row(record)
        sheet.add_row(row, style: styles, widths: widths, types: types)
      end
    else
      records.find_each do |record|
        row = record_to_row(record)
        sheet.add_row(row, style: styles, widths: widths, types: types)
      end
    end
  end

  def record_to_row(record)
    attributes.map do |attribute|
      record.send(attribute.to_sym)
    end
  end
end
