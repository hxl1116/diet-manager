require_relative './basic_food'
require_relative './recipe'

class FoodDB
  attr_reader :size, :basic_foods, :recipes

  #filename is the name of the FoodDB file to be used, ex: "food_db.txt"
  def initialize(filename)
    @size = 0

    @db_file = File.new(filename) #Open the database file

    @basic_foods = []
    @recipes = []

    #Read in the FoodDB file
    @db_file.each {|line|
      values = line.split(',') #Split the line up at the commas

      if values[1] == 'b' #BasicFood case
        add_basic_food(values[0], values[2].to_i) #Add the new food to our list
      elsif values[1] == 'r' #Recipe case
        values[2..values.length].each {|ingredient| ingredient.chomp!} #Remove newline characters
        add_recipe(values[0], values[2..values.length]) #Add the new Recipe to the recipes list
      else #The entry is invalid
        values[0].chomp.eql?("") ? nil : puts("Invalid food type found in food_db.txt")
      end
    }
  end

  #Returns true if a BasicFood with the name foodName exists in the database
  def contains_food?(food_name)
    contains = false
    basic_foods.each do |basic_food|
      if basic_food.name == food_name
        contains = true
      end
    end
    contains
  end

  #Returns true if a Recipe with the name recipeName exists in the database
  def contains_recipe?(recipe_name)
    contains = false
    recipes.each do |recipe|
      if recipe.name.downcase == recipe_name.downcase
        contains = true
      end
    end
    contains
  end

  #Returns true if there exists some entry in the database with the name itemName
  def contains?(item_name)
    if contains_food?(item_name) or contains_recipe?(item_name)
      true
    else
      false
    end
  end

  #Returns the BasicFood of the given name if it exists within the database, nil otherwise
  def get_food(food_name)
    if contains_food?(food_name)
      basic_foods.each {|food|
        if food.name == food_name
          return food
        end
      }
    else
      nil
    end
  end

  #Returns the Recipe of the given name if it exists within the database, nil otherwise
  def get_recipe(recipe_name)
    if contains_recipe?(recipe_name)
      recipes.each {|recipe|
        if recipe.name == recipe_name
          return recipe
        end
      }
    else
      nil
    end
  end

  #Returns the item of the given name if it exists within the database, nil otherwise
  def get(item_name)
    if contains? item_name
      if contains_food? item_name
        return get_food(item_name)
      else
        return get_recipe(item_name)
      end
    else
      nil
    end
  end

  #Returns a list of all items in the database that begin with the given prefix
  def find_matches(prefix)
    results = []
    basic_foods.each do |basic_food|
      if basic_food.name.downcase.start_with?(prefix.downcase)
        results.push(basic_food)
      end
    end
    recipes.each do |recipe|
      if recipe.name.downcase.start_with?(prefix.downcase)
        results.push(recipe)
      end
    end
  end

  #Constructs a new BasicFood and adds it to the database, returns true if successful, false otherwise
  def add_basic_food(name, calories)
    if contains_food?(name)
      false
    else
      basic_foods.push(BasicFood.new(name, calories))
      @size += 1
      true
    end
  end

  #Constructs a new Recipe and adds it to the database, returns true if successful, false otherwise
  def add_recipe(name, ingredient_names)
    if contains_recipe?(name)
      false
    else
      ingredients = []
      ingredient_names.each {|ingredient|
        ingredients.push(get_food(ingredient))
      }

      recipes.push(Recipe.new(name, ingredients))
      @size += 1
      true
    end
  end

  #Saves the database to @dbFile
  def save
    File.open(@db_file, "w+") {|fOut|
      #Write all BasicFoods to the database
      basic_foods.each {|food| fOut.write("#{food.name},b,#{food.calories}\n")}
      fOut.write("\n")

      #Write all Recipes to the database
      recipes.each {|recipe|
        fOut.write("#{recipe.name},r")

        #List the ingredients after the recipe name
        recipe.ingredients.each {|ingredient| fOut.write(",#{ingredient.name}")}
        fOut.write("\n")
      }
    }
  end
end
