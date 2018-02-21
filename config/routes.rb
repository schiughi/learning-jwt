Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api , format: 'json' do
    namespace :v1 do
      resources :auths
    end
  end
  get 'auth/:provider/callback', to: 'api/v1/auths#callback'
end
