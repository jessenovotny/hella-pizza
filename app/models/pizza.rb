class Pizza < ApplicationRecord
	has_many :pizza_toppings
	has_many :toppings, through: :pizza_toppings

	def add_toppings pizza_params
		if toppings = pizza_params["description"]
      toppings = toppings.gsub(',', '').gsub('and ', '').split(' ')
      self.toppings.clear
      toppings.each do |topping|
        topping = Topping.find_or_create_by(name: topping)
        self.toppings << topping unless self.toppings.include?(topping)
      end
    end
    self
	end
end
