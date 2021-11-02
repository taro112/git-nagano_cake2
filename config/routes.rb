Rails.application.routes.draw do
  devise_for :customers, controllers: {
  sessions:      'publics/sessions',
  passwords:     'publics/passwords',
  registrations: 'publics/registrations'
}

  devise_for :admins, controllers: {
  sessions:      'admin/sessions',
  passwords:     'admin/passwords',
  registrations: 'admin/registrations'
}

namespace :admin do
    resources :items, only: [:show, :update, :new, :edit, :index]
    resources :confirmations, only: [:new]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resources :homes, only: [:top]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
end

scope module: :public do
    resources :homes, only: [:top, :about]
    resources :items, only: [:index, :show]
    resources :customers, only: [:edit, :update, :my_page, :unsubscribe, :withdrawal]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all]
    resources :orders, only: [:new, :verification, :thank, :index, :show]
    resources :addresses, only: [:index, :edit, :update, :destroy]
  end
  
resources :customers do
  collection do
      get :my_page
      get :unsubscribe
      get :withdrawal
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
