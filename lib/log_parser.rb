require_relative './entry'

class LogParser
  attr_reader :entries

  def initialize filename
    @entries = {}

    if ! File.exist? filename
      raise "no such file #{filename}"
    end

    process filename
  end

  def process filename
    File.open(filename) { |log|
      log.each {|line| add_entry line }
    }
  end

  def size
    @entries.size
  end

  def visits
    # return the entries ordered by views descending
    @entries.values.sort {|a,b| b.views <=> a.views }
  end

  def unique_views
    @entries.values.sort {|a,b| b.unique <=> a.unique }
  end

  private def add_entry line
    parts = line.split(' ')
    @entries[parts[0]] ||= Entry.new parts[0]
    @entries[parts[0]].add_view parts[1]
  end
end