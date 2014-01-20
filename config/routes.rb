Bloccit::Application.routes.draw do

  

  get "posts/index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :users, only: [:show, :index]
  resources :posts, only: [:index] #this is for the 'popular' posts

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
		resources :comments, only: [:create, :destroy]
    match '/up-vote', to: 'votes#up_vote', as: :up_vote
    match '/down-vote', to: 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
	 end
  end

  #resources :posts do
	# resources :comments, only: [:create]
  #end
  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end
