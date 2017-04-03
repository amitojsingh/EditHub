Rails.application.routes.draw do

  devise_for :users
 get 'repositories/new'
 get 'repositories/:id', to: "repositories#show", as: "repository"
 get "repositories", to: "repositories#index", as: "repositories"
 post "repositories", to: "repositories#create"
 get "repositories/:id/generate", to: "repositories#generate",as: "generate_repository",:defaults=>{:format=>'json'}
  #mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
