
# class to hold an entry in the log file with a hash of visitor IP addresses
class Entry
  attr_reader :path
  attr_reader :views

  def initialize path
    @path = path
    @views = 0
    @uniques = {}
  end

  def add_view ip_addr
    @views += 1
    @uniques[ip_addr] = 1
  end

  def unique
    @uniques.size
  end
end