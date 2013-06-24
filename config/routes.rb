Pagernova::Application.routes.draw do
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show', as: :user
  get 'twilio/sms' => 'twilio#sms'
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :contact_methods
        resources :notification_rules
      end
      resources :alerts
    end
  end
end
