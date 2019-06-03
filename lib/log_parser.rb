require_relative './entry'

# parse a log file
class LogParser
  attr_reader :entries

  def initialize(filename)
    @entries = {}

    raise "no such file #{filename}" unless File.exist?(filename)

    process filename
  end

  def process(filename)
    File.open(filename) do |log|
      log.each do |line|
        add_entry line
      end
    end
  end

  def size
    @entries.size
  end

  def visits
    # return the entries ordered by views descending
    @entries.values.sort { |a, b| b.views <=> a.views }
  end

  def unique_views
    @entries.values.sort { |a, b| b.unique <=> a.unique }
  end

  private

  def add_entry(line)
    parts = line.split(' ')
    @entries[parts[0]] ||= Entry.new parts[0]
    @entries[parts[0]].add_view parts[1]
  end
end
