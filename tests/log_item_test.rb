require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative './log_item'

class LogItemTest < MiniTest::Test
  def setup
    @item = LogItem.new("Orange", Date.today)
  end
  
  #Tests the basic construction of a LogItem object
  def test_construction
    assert(@item.name.eql?("Orange"), "Name field was not initialized correctly")
    assert(@item.date.eql?(Date.today), "Date field was not initialized correctly")
  end
  
  #Tests the 'to_s' method of LogItem
  def test_to_s
    assert(@item.to_s.eql?("#{Date.today} Orange"), "to_s method formats string improperly")
  end
end

