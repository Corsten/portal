module Concerns
  module Uploads
    def resource_object
      model = ApplicationUploader.prepare_model_name(params[:model_name]).classify.constantize
      model.find(params[:model_id])
    end

    def resource_file
      resource_object.send params[:mounted_as]
    end

    def authorize_file(policy_namespace = nil)
      policy_finder = Pundit::PolicyFinder.new([*policy_namespace, resource_object].compact)
      policy_class_method = "#{params[:mounted_as]}?".to_sym
      return if policy_finder.policy.blank? || !policy_finder.policy.instance_methods.include?(policy_class_method)

      authorize policy_finder.object, policy_class_method
    end

    def raise_not_found(err = nil)
      err.backtrace.each { |backtrace_line| Rails.logger.error(backtrace_line) } if err.respond_to?(:backtrace)
      raise ActionController::RoutingError, 'Not found'
    end
  end
end
