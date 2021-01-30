module CoreExtensions
  module AutoSessionTimeout
    module ClassMethods
      # NOTE: https://github.com/pelargir/auto-session-timeout/blob/master/lib/auto_session_timeout.rb#L8
      def auto_session_timeout(seconds = nil)
        protect_from_forgery except: %i[active timeout]
        prepend_before_action do |c|
          if c.session[:auto_session_expires_at] && c.session[:auto_session_expires_at] < Time.current
            c.send :reset_session
          elsif c.session[:auto_session_expires_at].blank?
            unless c.request.original_url.start_with?(c.send(:active_url))
              offset = seconds || (current_user.respond_to?(:auto_timeout) ? current_user.auto_timeout : nil)
              c.session[:auto_session_expires_at] = Time.current + offset if offset&.positive?
            end
          end
        end
      end
    end
  end
end
