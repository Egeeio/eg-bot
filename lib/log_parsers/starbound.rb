# Yes, linter
module StarboundParser

  def self.parse

  end
  private

  def self.parse(log)
    return log.match(/(['])(?:(?=(\\?))\2.)*?\1/) if log_line.include?(") connected")
  end
end
