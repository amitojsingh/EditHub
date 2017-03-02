Rails.application.routes.draw do

 get 'repositories/new'
 get 'repositories/:id', to: "repositories#show", as: "repository"
 get "repositories", to: "repositories#index", as: "repositories"
 post "repositories", to: "repositories#create"
 post "repositories/:id/generate", to: "repositorie#generate", as: 'generate_repository'
 root "repositories#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end