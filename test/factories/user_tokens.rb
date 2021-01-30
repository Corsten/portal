FactoryBot.define do
  factory :user_token, class: 'User::Token' do
    body
    user
    kind { User::Token::KINDS.sample }

    trait :confirm_email do
      kind { :confirm_email }
    end
    trait :change_attrs do
      kind { :change_attrs }
    end
    trait :restore_password do
      kind { :restore_password }
    end

    factory :user_token_confirm_email, traits: [:confirm_email]
    factory :user_token_change_attrs, traits: [:change_attrs]
    factory :user_token_restore_password, traits: [:restore_password]
  end
end
