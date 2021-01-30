module Reporters::Helpers
  class UndefinedClaimKind < StandardError; end

  DEFAULT_FONT_SIZE = 12

  def init_styles(workbook)
    default_style_params = {
      alignment: { horizontal: :center, vertical: :center, wrap_text: true },
      border: { style: :thin, color: '00' },
      sz: DEFAULT_FONT_SIZE
    }
    date_style_params = default_style_params.merge(format_code: 'dd.mm.yyyy')

    workbook_styles[:default] = workbook.styles.add_style(default_style_params)
    workbook_styles[:date] = workbook.styles.add_style(date_style_params)
  end

  def workbook_styles
    @workbook_styles ||= {}
  end

  def merge_title_cells(sheet, column_count = nil)
    column_count ||= attributes.length
    last_cell_number = column_count.pred
    first_cell = Axlsx.cell_r(0, 0)
    last_cell = Axlsx.cell_r(last_cell_number, 0)
    sheet.merge_cells [first_cell, last_cell].join(':')
  end

  def merge_head_cells(sheet)
    attributes.each_with_index do |_attribute, index|
      sheet.merge_cells [Axlsx.cell_r(index, 1), Axlsx.cell_r(index, 2)].join(':') if sub_heads[index].blank?
    end
  end

  def merge_sub_head_cells(sheet)
    sub_head_cells = []
    attributes.each_with_index do |_attribute, index|
      next if sub_heads[index].blank?
      sub_heads_attributes = sub_heads.select { |head| head[sub_heads[index].keys.first].present? }
      if sub_head_cells.exclude?(sub_heads_attributes.first)
        sheet.merge_cells [Axlsx.cell_r(index, 1), Axlsx.cell_r(index + (sub_heads_attributes.count - 1), 1)].join(':')
        sub_head_cells.push(sub_heads_attributes.first)
      end
    end
  end

  def date_parse(data)
    Date.parse(data.to_s).strftime('%Y%m%d')
  end

  def params_interval(params)
    interval = {}
    interval[:min] = date_parse(params[:q][:created_at_gt]) if params.dig(:q, :created_at_gt) && params[:q][:created_at_gt].present?
    interval[:max] = date_parse(params[:q][:created_at_lt]) if params.dig(:q, :created_at_lt) && params[:q][:created_at_gt].present?
    interval
  end

  def report_interval(query, params)
    interval = params_interval(params)
    interval[:min] = date_parse(query.minimum(:created_at)) if interval[:min].blank? && query.minimum(:created_at).present?
    interval[:max] = date_parse(query.maximum(:created_at)) if interval[:max].blank? && query.maximum(:created_at).present?
    interval
  end

  def client_report_interval(first_client, last_client)
    interval = {}
    interval[:min] = date_parse(first_client.created_at) if first_client.present?
    interval[:max] = date_parse(last_client.created_at) if last_client.present?
    interval
  end
end
