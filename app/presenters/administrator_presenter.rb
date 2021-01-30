class AdministratorPresenter < BasePresenter
  def full_name
    [surname, name, patronymic].compact.join(' ')
  end

  def surname_and_initials
    initial_letters = [name&.first, patronymic&.first].map(&:presence).compact.map { |letter| "#{letter}." }
    [surname, *initial_letters].join(' ')
  end

  def firstname_with_lastname
    [surname, name].compact.join(' ')
  end
end
