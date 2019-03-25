# Yes, linter
module LogParser
  def self.parse(game)
    players = []
    logs = get_logs(game)
    logs.each_line do |log_line|
      match = game_switch(game, log_line)
      players.push(match)
    end
    players.compact!
  end

  def self.get_logs(game)
    `journalctl --since "15 seconds ago" --no-pager -u #{game}`
  end

  def self.game_switch(game, log_line)
    case game
    when "starbound"
      starbound(log_line)
    when "rust"
      rust(log_line)
    when "minecraft"
      minecraft(log_line)
    end
  end

  def self.starbound(log_line)
    log_line.match(/(['])(?:(?=(\\?))\2.)*?\1/).to_s if log_line.include?(") connected")
  end
end
