Rails.application.routes.draw do
  
  # root to: 'admin/orders#show'
  
  
  devise_for :customers, path:"", controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
  
}

  devise_for :admins, controllers: {
  sessions:      'admin/sessions',
  passwords:     'admin/passwords',
  registrations: 'admin/registrations'
}

namespace :admin do
    resources :items, only: [:show, :update, :new, :edit, :index, :create]
    resources :confirmations, only: [:new]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :genres, only: [:index, :edit, :update, :create]
    resources :homes, only: [:top]
    resources :orders, only: [:show, :update, :index]
    resources :order_details, only: [:update]
    get '/admin/sign_out' => 'devise/sessions#destroy'
end

get 'admin' => 'admin/homes#top'

scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resource :customers, only: [:edit, :update]
    get 'customers/my_page' => 'customers#my_page'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal'
    put 'customers/withdrawal' => 'customers#withdrawal'
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    get 'orders/thank' => 'orders#thank'
    post 'orders/verification' => 'orders#verification'
    resources :orders, only: [:new, :index, :show, :create]
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
  end
  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
