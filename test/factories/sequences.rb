FactoryBot.define do
  sequence :string, aliases: %i[surname name patronymic fio full_name body organization position] do |n|
    "string-#{n}"
  end

  sequence :number, aliases: %i[int] do |n|
    n
  end

  sequence :time, aliases: %i[concerted_time datetime] do
    Time.current
  end

  sequence :phone_number do
    '+7 800 200-06-00'
  end

  sequence :email do |n|
    "email-#{n}@example.com"
  end

  sequence :password do |n|
    "SuperPassword#{n}"
  end
  sequence :utc_offset do |n|
    "+#{n.to_s.last(2)}:00"
  end
end
