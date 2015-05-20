Rails.application.routes.draw do

  namespace :api do
    scope module: 'v1' do
      resources :growing_guides, only: [:index, :show], :path => "how_to_grow"
      resources :problem_solvers, only: [:index, :show], :path => "problem_solver"
      post '/generateToken', to: "tokenizer#generate_token"
    end
  end
end
