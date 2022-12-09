class BasicFood
  attr_accessor :name, :calories

  #foodName is the name of the BasicFood and calories is the number of calories in this BasicFood
  def initialize(food_name, calories)
    @name = food_name
    @calories = calories
  end

  def name
    @name
  end

  def calories
    @calories
  end
  
  #Returns a string representation of this BasicFood formatted for printing
  def to_s
    "#{name} #{calories}"
  end
end

