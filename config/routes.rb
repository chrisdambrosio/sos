Sos::Application.routes.draw do
  get "schedules/index"
  devise_for :users
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show', as: :user
  get 'schedules' => 'schedules#index'
  get 'schedules/:id' => 'schedules#index'
  get 'twilio/sms' => 'twilio#sms'
  post 'twilio/phone' => 'twilio#phone'
  post 'twilio/phone/input' => 'twilio#phone_input'
  get 'alerts/:id' => 'alerts#show'
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :contact_methods
        resources :notification_rules
      end
      resources :alerts do
        resources :log_entries, only: [:index]
      end
      resources :schedules
    end
  end
end
