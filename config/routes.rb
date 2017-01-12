Rails.application.routes.draw do

	root "sessions#new"

  get "sign_in" => "sessions#new"
  post "sessions" => "sessions#create", as: :sessions
  delete "sign_out" => "sessions#destroy", as: :sign_out

  resources :users

end
