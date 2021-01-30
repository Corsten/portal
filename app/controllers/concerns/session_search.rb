module Concerns
  module SessionSearch
    extend ActiveSupport::Concern

    included do
      def search_params
        clear_search_data
        session[search_key] = params[:q] if params[:q]
        params[:q] = session[search_key] if params[:q].blank?
        params[:q]
      end

      def clear_search_data
        session.delete(search_key) if params[:clear_search]
      end

      def search_key
        "#{controller_name}_search".to_sym
      end
    end
  end
end
