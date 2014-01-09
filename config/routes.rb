Bloccit::Application.routes.draw do

  

  devise_for :users

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts do
	 resources :comments, only: [:create]
  end
  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end
