Rails.application.routes.draw do
	root to: "pizzas#index"
  resources :toppings
  resources :pizzas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
