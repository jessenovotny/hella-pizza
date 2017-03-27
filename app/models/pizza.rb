class Pizza < ApplicationRecord
	has_many :pizza_toppings
	has_many :toppings, through: :pizza_toppings

	accepts_nested_attributes_for :toppings

	def toppings_attributes=(topping_hash)
    topping_hash.values.each do |attribute|
      unless attribute.values.first.empty?
        topping = Topping.find_or_create_by(attribute)
        toppings << topping unless toppings.include?(topping)
      end
    end
  end

	def update_toppings # Just for fun		
		if toppings = self.description
      toppings = toppings.gsub(',', '').gsub('and ', '').split(' ')
      self.toppings.clear
      toppings.each do |topping|
        topping = Topping.find_or_create_by(name: topping)
        self.toppings << topping unless self.toppings.include?(topping)
      end
    end
    self
	end

	def update_description # Just for fun		
		desc = self.toppings.map{|topping| topping.name}
		if desc.count > 2
			desc[-1] = "and #{desc.last}"
			desc = desc.join(', ')
		elsif desc.count == 2
			desc[-1] = "and #{desc.last}"
			desc = desc.join(' ')
		else
			desc = desc.first
		end
		self.description = desc
	end
				
end
