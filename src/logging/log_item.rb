require 'date'

class LogItem
  attr_accessor :name, :date

  #itemName is the name of the BasicFood and date is the date (civil format : xx/xx/xxxx) for which the food was added
  def initialize(item_name, date)
    @name = item_name
    @date = date
  end

  def name
    @name
  end

  def date
    @date
  end

  #Returns a string representation of this LogItem formatted for printing
  def to_s
    "#{date} #{name}"
  end
end

