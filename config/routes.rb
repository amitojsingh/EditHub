Rails.application.routes.draw do
  get 'gitrepos/newrepo'
  post 'gitrepos/newrepo'
  get 'gitrepos/:id', to: 'gitrepos#show', as: 'gitrepo'
  post 'gitrepos', to: 'gitrepos#create'
  get 'github/:id/:url(*all)', to: 'gitrepos#moveto'
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'repositories/new'
  get 'repositories/:id', to: 'repositories#show', as: 'repository'
  get 'repositories', to: 'repositories#index', as: 'repositories_index'
  post 'repositories', to: 'repositories#create'
  get 'repositories/:id/generate', to: 'repositories#generate', as: 'generate_repository', defaults: {:format=>'json'}
  get 'uploads/extract/:id/:upload_file_name(*all)', to: 'repositories#moveto'

  devise_scope :user do
    authenticated :user do
      root 'repositories#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  # mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
