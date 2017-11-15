class Pantry

  attr_reader :stock, :cook_book

  def initialize
    @stock = {}
    @cook_book = []
  end

  def stock_check(ingredient)
    if @stock[ingredient]
      @stock[ingredient]

    else
      0
    end
  end

  def restock(ingredient, amount)
    #@stock[ingredient] = amount
    if @stock[ingredient]
     @stock[ingredient] +=  amount

    else
      @stock[ingredient] = amount
    end
  end

  def convert_units(recipe)
    converted = {}
    ingredients = recipe.ingredient_types
    ingredients.each do |ingredient|
      converted[ingredient] = convert_quantity(recipe.ingredients[ingredient])
      #{quantity: 0, units: ""}
    end
    converted
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

  def add_to_cookbook(recipe)
    @cook_book << recipe
  end

  def has_all_ingredients(ingredients_list)
    ingredients_list.to_a.all? do |ingredient|
      @stock[ingredient[0]] && @stock[ingredient[0]] >= ingredient[1]
    end
  end

  def what_can_i_make
    recipes = @cook_book.select do |recipe|
      has_all_ingredients(recipe.ingredients)
    end
    recipes.map {|recipe| recipe.name}
  end
end
