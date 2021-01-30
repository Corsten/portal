FactoryBot.define do
  factory :user do
    full_name
    phone_number
    email
    position
    organization
    password
    password_confirmation { password }

    trait :blocked do
      state { :blocked }
    end

    trait :actual do
      state { :actual }
    end

    factory :blocked_user, traits: [:blocked]
    factory :actual_user, traits: [:actual]
  end
end
