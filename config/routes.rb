Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  apipie

  root controller: 'static', action: '/'

  mount GrapeSwaggerRails::Engine => '/swagger' if Rails.env.staging? || Rails.env.development?

  namespace 'api' do
    namespace 'v1', defaults: { format: 'json' } do
      post 'auth/google_signup', to: 'authentication#google_signup'
    end
  end
end
