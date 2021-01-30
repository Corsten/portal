module AdministratorRolesHelper
  AVAILABLE_ADMINISTRATOR_ROLES_PAIRS_BY_ROLE = {
    admin: %i[admin]
  }.freeze

  def allowed_administrator_roles_list_for(administrator)
    result = AVAILABLE_ADMINISTRATOR_ROLES_PAIRS_BY_ROLE.fetch(administrator.role.to_sym, [])
    result.map { |element| [t("enumerize.administrator.role.#{element}"), element] }
  end
end
