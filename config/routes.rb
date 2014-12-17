Rails.application.routes.draw do

  devise_for :users, :skip => :registrations
  get 'home/index'
  get 'contact' => 'home#contact', as: :contact
  get 'portfolio' => 'home#portfolio', as: :portfolio

  resources :articles

  root 'home#index'


end
