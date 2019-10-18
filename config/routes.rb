Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations'
 }

 get 'comprar/:id', to: 'products#comprar', as: 'comprar'

 get 'usuario/:id', to: 'products#profile', as: 'profile'
 get 'misventas', to: 'products#ventas', as: 'ventas'

 root "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
