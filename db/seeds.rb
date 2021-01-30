Administrator.find_or_create_by(email: 'admin@portal.ru') do |administrator|
  administrator.surname = 'Admin'
  administrator.name = 'Admin'
  administrator.password = '123456'
  administrator.email = 'admin@portal.ru'
  administrator.role = 'admin'
end
