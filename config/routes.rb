Rails.application.routes.draw do
  namespace :api do
    scope module: 'v1' do
      resources :growing_guides, only: [:index, :show], :path => "how_to_grow"
      post '/generateToken', to: "tokenizer#generate_token"
    end
  end
end
