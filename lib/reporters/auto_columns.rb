module Reporters::AutoColumns
  extend ActiveSupport::Concern

  DEFAULT_WIDTH = 20
  DEFAULT_STYLE = :default
  DEFAULT_TYPE = nil

  included do
    class << self
      include Reporters::Helpers
      def add_column(attribute, params)
        attributes.push(attribute)
        widths.push(params[:width] || DEFAULT_WIDTH)
        styles.push(params[:style] || DEFAULT_STYLE)
        types.push(params[:type] || DEFAULT_TYPE)
        head.push(params[:parent].present? ? I18n.t(params[:parent].to_s, scope: 'reports.columns') : params[:title])
        sub_heads.push(params[:parent].present? ? { params[:parent] => params[:title] } : {})
      end

      def head
        @head ||= []
      end

      def sub_heads
        @sub_heads ||= []
      end

      def attributes
        @attributes ||= []
      end

      def widths
        @widths ||= []
      end

      def styles
        @styles ||= []
      end

      def types
        @types ||= []
      end
    end

    private

    def head
      self.class.head
    end

    def sub_heads
      self.class.sub_heads
    end

    def attributes
      self.class.attributes
    end

    def widths
      self.class.widths
    end

    def styles
      @styles ||= self.class.styles.map { |style| @workbook_styles[style] }
    end

    def types
      self.class.types
    end
  end
end
