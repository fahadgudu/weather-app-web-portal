Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    scope module: 'v1' do
      resources :weathers, only: [:index, :show]
      post '/register' => 'weathers#register', :as => :user_register
      post '/weather_update' => 'weathers#weather_update', :as => :user_weather_update
      post '/do_it' => 'weathers#do_it', as: :user_do_it
      post '/weather_forecast' => 'weathers#weather_forecast', as: :user_weather_forecast
      resources :devices, only: [:create] do
        member do
          post :notify
        end
      end
      resources :video_playlists, only: [:index]
      post '/generateToken', to: "tokenizer#generate_token"
    end
  end
end
