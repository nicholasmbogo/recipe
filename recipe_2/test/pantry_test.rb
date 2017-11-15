require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/pantry"
require "./lib/recipe"

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_is_initialized_with_stock
    pantry = Pantry.new


    assert_equal ({}), pantry.stock
  end

  def test_has_stock_check
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_can_restock
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.stock_check("Cheese")

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_has_restock_more
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)
    pantry.stock_check("Cheese")

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_can_convert_units_for_recipe
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
