Rails.application.routes.draw do

  devise_for :users

  namespace :admin do 
    resources :products
    resources :orders do 
      member do 
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  namespace :account do 
    resources :orders
  end

  resources :products do 
    member do 
      post :add_to_cart
    end
    collection do 
      post :search
    end
  end

  resources :carts do 
    collection do 
      post :checkout
    end

    resources :items, :controller => "cart_items"

  end

  resources :orders do 
    member do 
      get :pay_with_credit_card
    end

    resources :card_charges
  end

  root :to => "products#index"

  require 'sidekiq/web'
  # Admin only
  authenticate :user, lambda { |u| u.admin? } do  
    mount Sidekiq::Web => '/sidekiq'
  end
end