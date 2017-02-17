Rails.application.routes.draw do
  resource 'repositories'
  get 'repositories/new'
  get 'repositories/index'
  root "repositories#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
