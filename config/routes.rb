Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :rooms do
    get 'allocate_repetitive', to: 'rooms#allocate_repetitive'
    get 'allocate_non_repetitive', to: 'rooms#allocate_non_repetitive'
    post 'allocate/repetitive_event', to: 'rooms#allocate_repetitive_event'
    post 'allocate/non_repetitive_event', to: 'rooms#allocate_non_repetitive_event'
  end
end
