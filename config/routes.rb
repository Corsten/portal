Rails.application.routes.draw do
  constraints Routes::AdminConstraint do
    require 'resque/server'
    mount Resque::Server.new, at: '/backend/queue'
  end

  scope '/backend' do
    scope module: :web do
      get 'active', to: 'sessions#active'
      get 'timeout', to: 'sessions#timeout'

      root 'admin/sessions#new'

      get 'uploads/:model_name/:mounted_as/:model_id', to: 'uploads#file', as: :uploads_file

      resources :files, only: %i[product_documents testing_methods archives] do
        collection do
          get 'product_documents/:product_id', to: 'files#product_documents', as: :products
          get 'testing_method_documents/:testing_method_id', to: 'files#testing_method_documents', as: :testing_methods
          get 'archive_documents/:archive_id', to: 'files#archive_documents', as: :archives
          get 'main_page_documents/:document_id', to: 'files#main_page_documents', as: :main_page_documents
        end
      end

      resource :user, only: [] do
        get :confirm_email
      end

      namespace :admin do
        get 'uploads/:model_name/:mounted_as/:model_id', to: 'uploads#file', as: :uploads_file
        resource :session, only: %i[new create destroy]

        resources :administrators, only: %i[index new create edit update destroy] do
          post :block, on: :member
          post :unblock, on: :member
        end

        resources :users, only: %i[index new create edit update destroy] do
          post :block, on: :member
          post :unblock, on: :member
        end

        resources :categories do
          scope module: :categories do
            resources :groups, only: %i[new create edit update destroy] do
              scope module: :groups do
                resources :products, only: %i[new create edit update destroy]
                resources :pilots, only: %i[new create edit update destroy]
                resources :testing_methods, only: %i[new create edit update destroy]
                resources :archives, only: %i[new create edit update destroy]
              end
            end
          end
        end

        resources :documents, only: %i[index new create edit update destroy]
        resources :events, only: %i[index new create edit update destroy]
        resources :working_group_members, only: %i[index new create edit update destroy]
        resources :events_claims, only: %i[index edit] do
          post :block, on: :member
          post :unblock, on: :member
        end
      end
    end

    namespace :api do
      namespace :web do
        resources :users, only: %i[create] do
          collection do
            post :send_restore_password_email
            patch :update_password
          end
        end
        resources :user_tokens, only: [] do
          get :restore_password_token_exist, on: :collection
        end

        namespace :lk do
          resource :session, only: %i[check create destroy] do
            get :check
          end
          resource :profile, only: %i[show update]

          resource :testing_methods, only: %i[create]

          resource :archives, only: %i[create]

          get 'main_page/content', to: 'main_page#content'

          resource :pilots, only: %i[import] do
            get 'pilot_template', to: 'pilots#pilot_template'
            post 'import', to: 'pilots#import'
          end

          resource :event_claims, only: %i[create check] do
            get :check
          end

          resources :registers, only: %i[product_register pilot_register testing_method_register archive_register categories_list category_groups_list] do
            collection do
              get 'product_register', to: 'registers#product_register', as: :product_register
              get 'pilot_register', to: 'registers#pilot_register', as: :pilot_register
              get 'testing_method_register', to: 'registers#testing_method_register', as: :testing_method_register
              get 'archive_register', to: 'registers#archive_register', as: :archive_register
              get 'categories_list', to: 'registers#categories_list', as: :categories_list
              get 'category_groups_list', to: 'registers#category_groups_list', as: :category_groups_list
              get 'export_product_register', to: 'registers#export_product_register', as: :export_product_register
              get 'export_pilot_register', to: 'registers#export_pilot_register', as: :export_pilot_register
            end
          end
        end
      end
    end
  end
end
