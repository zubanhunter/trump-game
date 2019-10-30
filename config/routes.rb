Rails.application.routes.draw do
  resources :lies
  resources :truths do
    member do
      post 'accept'
    end

    collection do
      get 'review'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'trump#gen'
end
