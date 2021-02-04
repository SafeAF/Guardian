Rails.application.routes.draw do
  get 'home/index'
  resources :hosts
  resources :users
  root to: "home#index"
  
  get "/fetch_file_delta" => 'hosts#from_file_delta', as: 'fetch_file_delta'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
