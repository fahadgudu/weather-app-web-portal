Rails.application.routes.draw do

  namespace :api do
    scope module: 'v1' do
      resources :growing_guides, only: [:index, :show], :path => "how_to_grow"
      resources :problem_solvers, only: [:index, :show], :path => "problem_solver"
      resources :stores, only: [:index, :show], :path => "retailers"
      resources :categories, only: [:index, :show] do
        resources :products, only: [:index, :show]
      end
      resources :search, only: [] do
        collection do
          get "/:section", to: "search#index", as: :section, constraints: { section: /how_to_grow|product|retailer/ }
        end
      end
      post '/generateToken', to: "tokenizer#generate_token"
    end
  end
  get "/docs", to: "api_docs#index"
end
