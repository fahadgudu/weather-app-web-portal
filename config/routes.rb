Rails.application.routes.draw do
  namespace :api do
    scope module: 'v1' do
      post '/generateToken', to: "tokenizer#generate_token"
    end
  end
end
