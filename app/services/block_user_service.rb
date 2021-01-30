module BlockAdministratorService
  module_function

  def block!(administrator)
    administrator.update(failed_auth_attempts: 0) if administrator.block!
  end
end
