Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  apipie

  root controller: 'static', action: '/'

  mount GrapeSwaggerRails::Engine => '/swagger' if Rails.env.staging? || Rails.env.development?

  namespace 'api' do
    namespace 'v1', defaults: { format: 'json' } do
      post 'auth/google_signup', to: 'authentication#google_signup'
      resource :user, only: [:show]
      resources :rewards, only: [:index, :create, :show, :update]
      resources :category_reason_badges, only: [:index]
      resources :category_reasons, only: [:index]
      resources :categories, only: [:index]
      resources :badges, only: [:index]
    end
  end
end
