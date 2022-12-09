require_relative './basic_food'

class Recipe
  attr_accessor :name, :ingredients, :calories

  #recipeName is the name of this recipe and ingredientsList is the list of BasicFood objects in this recipe
  def initialize(recipe_name, ingredients_list)
    @name = recipe_name
    @ingredients = ingredients_list.sort {|x, y| x.name <=> y.name} #Sorts the list by ingredient name
    @calories = 0
    @ingredients.each {|food|
      @calories += food.calories
    }
  end

  def name
    @name
  end

  def ingredients
    @ingredients
  end

  def calories
    @calories
  end

  #Returns a string representation of this Recipe formatted for printing
  def to_s
    result = @name
    @ingredients.each {|ingredient| result += " #{ingredient.name}"}
    result
  end
end

