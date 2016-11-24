Rails.application.routes.draw do
  get 'b/:url', to: 'redirections#redirect'
  get 'invalid_url', to: 'pages#invalid_url'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :short_urls
      resources :users, only: :create
    end
  end
end
