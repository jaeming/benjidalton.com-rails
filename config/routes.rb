Rails.application.routes.draw do

  root 'home#index'
  devise_for :users, :skip => :registrations
  get 'about' => 'home#index', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'portfolio' => 'home#portfolio', as: :portfolio

  resources :articles

  namespace :api do
    resources :articles
    get 'recent_posts' => 'articles#recent', as: :recent_posts
  end

end
