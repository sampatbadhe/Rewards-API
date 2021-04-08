Rails.application.routes.draw do
  apipe

  root controller: 'static', action: '/'

  mount GrapeSwaggerRails::Engine => '/swagger' if Rails.env.staging? || Rails.env.development?

  namespace 'api' do
    namespace 'v1', defaults: { format: 'json' } do
      post 'auth/signup', to 'authentication#signup'
    end
  end
end
