Rails.application.routes.draw do

  root to: 'home#index'

  resources :suppliers, except: [:edit, :update, :destroy] do
    resources :reviews, shallow: true, except: [:index, :edit, :update, :destroy]
  end

end
