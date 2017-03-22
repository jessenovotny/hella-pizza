Rails.application.routes.draw do
	root to: "pizzas#index"
  resources :toppings
  resources :pizzas
  post "/pizzas/:pizza_id/toppings", to: 'pizzas#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
