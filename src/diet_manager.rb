require_relative './food_db'
require_relative './log'

class DietManager
  def initialize
    @db_file = "food_db.txt"
    @log_file = "diet_log.txt"
    @database = FoodDB.new(@db_file)
    @log = Log.new(@log_file)
    @db_changed = false
    @log_changed = false
  end

  #Handles the 'quit' command which exits the DietManager
  def command_quit
    Log.save
    FoodDB.save
    exit
  end

  #Handles the 'save' command which saves the FoodDB and Log if necessary
  def command_save
    Log.save
    FoodDB.save
  end

  #Handles the 'new food' command which adds a new BasicFood to the FoodDB
  def command_new_food(name, calories)
    add_basic_food(name, calories)
  end

  #Handles the 'new recipe' command which adds a new Recipe to the FoodDB
  def command_new_recipe(name, ingredients)
    add_recipe(name, ingredients)
  end

  #Handles the 'print' command which prints a single item from the FoodDB
  def command_print(name)
    puts get(name)
  end

  #Handles the 'print all' command which prints all items in the FoodDB
  def command_print_all
    get_entries.each {|entry| puts entry}
  end

  #Handles the 'find' command which prints information on all items in the FoodDB matching a certain prefix
  def command_find(prefix)
    find_matches(prefix).each {|match| puts match}
  end

  #Handles both forms of the 'log' command which adds a unit of the named item to the log for a certain date
  def command_log(name, date = Date.today)
    add_log_item(name, date)
  end

  #Handles the 'delete' command which removes one unit of the named item from the log for a certain date
  def command_delete(name, date)
    remove_log_item(name, date)
  end

  #Handles both forms of the 'show' command which displays the log of items for a certain date
  def command_show(date = Date.today)
    get_entries.each {|entry|
      if entry.date == input[1]
        puts entry
      end
    }
  end

  #Handles the 'show all' command which displays the entire log of items
  def command_show_all
    get_entries.each {|entry| puts entry}
  end

end #end DietManager class


#MAIN

diet_manager = DietManager.new

puts "Input a command > "

#Read commands from the user through the command prompt
$stdin.each {|line|
  input = Array.new(line.split)
  case input[0]
  when "quit"
    command_quit
  when "save"
    command_save
  when "new food"
    command_new_food(input[1], input[2])
  when "new recipe"
    command_new_recipe(input[1], [input[2]...input[-1]].flatten)
  when "print"
    command_print(input[1])
  when "print all"
    command_print_all
  when "find"
    command_find(input[1])
  when "log"
    command_log(input[1])
  when "delete"
    command_delete(input[1], input[2])
  when "show"
    command_show
  when "show all"
    command_show_all
  else
    puts "Invalid command"
  end
} #closes each iterator

#end MAIN
