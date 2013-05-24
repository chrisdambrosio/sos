Pagernova::Application.routes.draw do
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show', as: :user
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      resources :contact_methods
    end
  end
end
