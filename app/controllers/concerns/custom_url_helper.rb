module Concerns
  module CustomUrlHelper
    extend ActiveSupport::Concern

    included do
      def admin_root_path_for(administrator)
        case administrator.role

        when 'admin'
          admin_administrators_path
        end
      end
    end
  end
end
