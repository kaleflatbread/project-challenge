Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :dogs do
    resources :likes
  end
  root to: "dogs#index"

  get 'dogs/:id/like', to: 'dogs#like', as: 'like'
  delete 'dogs/:id/unlike', to: 'dogs#unlike', as: 'unlike'

end
