class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    if @stock[ingredient]
      @stock[ingredient]

    else
      0
    end
  end

  def restock(ingredient, amount)
    if @stock[ingredient]
      @stock[ingredient] += amount

    else
      @stock[ingredient] = amount
    end
  end

  def convert_units(recipe)
    converted = {}
    ingredients = recipe.ingredient_types
    ingredients.each do |ingredient|
      converted[ingredient] = convert_quantity(recipe.ingredients[ingredient])
    end
  end


  def convert_quantity(universal_amount)
    #{quantity: universal_amount, units: ""}
    if universal_amount > 100
      {quantity: universal_amount / 100, units:"Centi-Units"}

    elsif universal_amount < 1
      {quantity: universal_amount * 1000, units: "Milli-Units"}

    else
      {quantity: universal_amount, units: "Universal Units"}
    end
  end
end
