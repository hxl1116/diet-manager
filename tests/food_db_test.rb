require 'minitest/autorun' #We need Ruby's unit testing library
require_relative './food_db'

class FoodDBTest < MiniTest::Test
  def setup #setup method is run automatically before each test_xxx
    @fdb = FoodDB.new("food_db.txt")
    @orange = BasicFood.new("Orange", 67)
    @bread = BasicFood.new("Bread", 80)
    @pb = BasicFood.new("Peanut Butter", 175)
    @jelly = BasicFood.new("Jelly", 155)
    @recipe = Recipe.new("PB&J", [@bread, @pb, @jelly, @bread])
    @ham = BasicFood.new("Ham", 145)
    @mustard = BasicFood.new("Mustard", 165)
    @ham_sandwich = Recipe.new("Ham Sandwich", [@bread, @ham, @mustard, @bread])
    @super_food = Recipe.new("Super Food", [@orange, @recipe])
  end

  #Tests if there are entries in the DB after food_db.txt is read
  def test_db_initialization
    assert(@fdb.size > 0, "Database entries not correctly read in")
  end

  #Tests the 'contains_food?' method of FoodDB
  def test_contains_food
    assert(@fdb.contains_food?("Orange"), "Doesn't find food that should exist")
  end

  #Tests the 'contains_recipe?' method of FoodDB
  def test_contains_recipe
    assert(@fdb.contains_recipe?("Chicken Sandwich"), "Doesn't find recipe that should exist")
  end

  #Tests the 'contains?' method of FoodDB
  def test_contains
    assert(@fdb.contains?("Orange"), "Doesn't find food that should exist")
    assert(@fdb.contains?("Chicken Sandwich"), "Doesn't find recipe that should exist")
  end

  #Tests the 'get_food' method of FoodDB
  def test_get_food
    assert(@fdb.get_food("Orange").eql?(@orange), "Gets incorrect food")
  end

  #Tests the 'get_recipe' method of FoodDB
  def test_get_recipe
    assert(@fdb.get_recipe("PB&J").eql?(@recipe), "Gets incorrect recipe")
  end

  #Tests the 'get' method of FoodDB
  def test_get
    assert(@fdb.get("Orange").eql?(@orange), "Gets incorrect food")
    assert(@fdb.get("PB&J").eql?(@recipe), "Gets incorrect recipe")
  end

  #Tests the 'find_matches' method of FoodDB
  def test_find_matches

  end

  #Tests the 'add_basicFood' method
  def test_add_food
    assert(!@fdb.add_basic_food("Orange", 67), "Adds food that already exists")
    assert(@fdb.add_basic_food("Cucumber", 47), "Failed to add new food")
  end

  #Tests the 'add_recipe' method
  def test_add_recipe
    assert(!@fdb.add_recipe(@recipe.name, @recipe.ingredients), "Adds recipe that already exists")
    assert(@fdb.add_recipe(@ham_sandwich.name, @ham_sandwich.ingredients), "Failed to add new recipe")
  end

  #Tests the addition of a Recipe with a Recipe as one of its ingredients
  def test_recipe_within_recipe
    assert(@fdb.add_recipe(@super_food.name, @super_food.ingredients), "Failed to add Super Food recipe")
    assert(@fdb.contains_recipe?("Super Food"))
    assert(@fdb.get_recipe("Super Food").ingredients[1].name.eql?(@ham_sandwich).name, "Recipe doesn't contain another recipe")
  end
end
