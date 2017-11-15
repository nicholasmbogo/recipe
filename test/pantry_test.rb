require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/recipe'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_stock_is_initialized_with_an_empty_hash
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_stock_can_be_checked
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_can_restock_when_stock_is_empty
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_can_restock_when_stock_is_not_empty
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_can_convert_units_for_recipe
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    pantry = Pantry.new
    # Convert units for this recipe

    assert_equal pantry.convert_units(r),({"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"}, "Cheese" => {quantity: 75, units: "Universal Units"}, "Flour" => {quantity: 5, units: "Centi-Units"}})
  end

  def test_it_can_add_to_cook_book
    pantry = Pantry.new
    # Building our recipe
    r1 = Recipe.new("Cheese Pizza")
    r2 = Recipe.new("Brine Shot")
    r3 = Recipe.new("Peanuts")
    # Adding the recipe to the cookbook
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_equal 3, pantry.cook_book.count
    assert_instance_of Recipe, pantry.cook_book.first
  end

  def test_can_determine_if_it_stock_has_ingridients_list
    pantry = Pantry.new
    ingredients_list = {"cheese" => 50, "flour" =>  30}
    pantry.restock("cheese", 100)
    pantry.restock("flour", 50)

    assert_equal true, pantry.has_all_ingredients(ingredients_list)
  end

  def test_can_determine_if_ii_stock_does_not_have_ingridients_list
    pantry = Pantry.new
    ingredients_list = {"cheese" => 50, "flour" =>  30}
    pantry.restock("cheese", 10)
    pantry.restock("flour", 50)

    assert_equal false, pantry.has_all_ingredients(ingredients_list)
  end

  def test_can_choose_what_to_make
    pantry = Pantry.new
    # Building our recipe
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    # Adding the recipe to the cookbook
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
    # Stock some ingredients
    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)
    # What can i make?
    assert_equal pantry.what_can_i_make,["Brine Shot", "Peanuts"]
    # How many can i make?
  end
end
