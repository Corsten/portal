FactoryBot.define do
  factory :administrator do
    surname
    name
    patronymic
    email
    password

    trait :blocked do
      state { :blocked }
    end

    trait :admin do
      role { :admin }
    end

    trait :admin_with_notifications do
      new_pilots_notification { true }
      new_users_notification { true }
      new_testing_methods_notification { true }
    end

    factory :blocked_administrator, traits: [:blocked]
    factory :admin, traits: [:admin]
    factory :admin_with_notifications, traits: [:admin_with_notifications]
  end
end
