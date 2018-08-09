Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'categories#index'
  resources :categories do
    resources :items, only: [:new, :create]
  end
  resources :items, only: [:edit, :update, :index, :destroy] do
    resources :item_taxes
  end
end