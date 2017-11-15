class Recipe

  attr_reader :name, :ingredient

  def initialize(name)
    @name = name
    @ingredient = {}
  end

  def ingredient_types(recipe)
    @ingredient.keys
  end

  def add_ingredient(ingredient_name, amount)
    @ingredient[ingredient_name] = amount
  end

  def amount_required(ingredient_name)
    @ingredient[ingredient_name]
  end
end
