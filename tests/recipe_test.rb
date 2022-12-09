require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative './recipe'

class RecipeTest < MiniTest::Test
  def setup
    @bread = BasicFood.new("Bread", 80)
    @pb = BasicFood.new("Peanut Butter", 175)
    @jelly = BasicFood.new("Jelly", 155)
    @recipe = Recipe.new("PB&J", [@bread, @pb, @jelly, @bread])
  end

  #Tests the initial construction of a Recipe
  def test_construction
    assert(@recipe.name.eql?("PB&J"), "Name field was not initialized correctly")
    assert(@recipe.ingredients == [@bread, @pb, @jelly, @bread].sort{|x, y| x.name <=> y.name},
           "Ingredients field was not initialized correctly")
    assert(@recipe.calories == 490, "Calories field was not initialized correctly")
  end
  
  #Tests the 'to_s' method of Recipe
  def test_to_s
    assert(@recipe.to_s.eql?("PB&J Bread Bread Jelly Peanut Butter"), "to_s method formats string improperly")
  end

end

