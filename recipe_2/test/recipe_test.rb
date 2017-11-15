require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/recipe"

class RecipeTest < Minitest::Test

  def test_it_exists
    r = Recipe.new("Berbeque")

    assert_instance_of Recipe, r
  end

  def recipe_can_add_ingridients
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    pantry = Pantry.new
    assert_equal pantry.convert_units(r),({"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
        "Cheese"         => {quantity: 75, units: "Universal Units"},
        "Flour"          => {quantity: 5, units: "Centi-Units"}})
  end
end
