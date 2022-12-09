require_relative './log_item'

class Log
  attr_accessor :size

  #filename is the name of the Log file to be used
  def initialize(filename)
    @log = Hash.new # key: @date, value: [@log_item(@date, @name), ...]
    @size = 0
    @log_file = File.new(filename) #Open the log file

    #Read in the Log file
    @log_file.each {|line|
      values = line.split(',') #Split the line at the commas
      date_parts = values[0].split('/') #Split the date field up at the slashes

      date = Date.parse("#{date_parts[2]}-#{date_parts[0]}-#{date_parts[1]}") #Parse the date string into a valid Date object

      add_log_item(values[1].chomp!, date)
    }
  end

  def size
    @size
  end

  #Adds a LogItem to the Log for the given date and name, returns true if successful, false otherwise
  def add_log_item(name, date)
    if name.eql?(nil) || date.eql?(nil)
      false
    else
      if contains? name, date
        @log.fetch(date).push(LogItem.new(name, date))
        @size += 1
        true
      else
        @log[date] = Array.new.push(LogItem.new(name, date))
        @size += 1
        true
      end
    end
  end

  #Removes a LogItem from the Log for the given date and name
  def remove_log_item(name, date)
    if contains? name, date
      item = log.fetch date
      log.remove name
      item
    else
      nil
    end
  end

  #Returns true if there is an entry for this date with the given name, false otherwise
  def contains?(name, date)
    # TODO-Fix contains
    if @log.has_key?(date) && @log[date].include?(name)
      true
    else
      false
    end
  end

  #Returns an Array of LogItems for the given date, nil if there are no entries for the date
  #If no date is passed, returns all entries in the Log
  def get_entries(date = nil)
    if date.nil?
      @log.values
    else
      if @log.has_key?(date)
        @log[date]
      else
        nil
      end
    end
  end

  #Saves the log to @logFile
  def save
    #Write all save data to the log file
    File.open(@log_file, "w+") {|f_out|
      get_entries.flatten.each {|log_item|
        f_out.write(log_item.to_s)
        f_out.write("\n")
      }
    }
  end
end

