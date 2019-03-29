# Yes, linter
class LogParser
  attr_reader :players
  def initialize(games)
    @players = games
  end

  def parse
    @players.each do |key|
      logs = get_logs(key.first())
      logs.each_line do |log_line|
        match = game_switch(key.first(), log_line)
        @players[key.first()].push(match) if match.nil? == false && match.empty? == false
      end
    end
  end

  def reset
    @players.each do |key|
      @players[key.first()] = []
    end
  end

  private

  def get_logs(game)
    `journalctl --no-pager -u #{game}`
  end

  def game_switch(game, log_line)
    case game
    when "starbound"
      starbound(log_line)
    when "rust"
      rust(log_line)
    when "minecraft"
      minecraft(log_line)
    end
  end

  def starbound(log_line)
    log_line.match(/(['])(?:(?=(\\?))\2.)*?\1/).to_s().tr("'", "") if log_line.include?(") connected")
  end

  def rust(log_line)
    log_line.match(%r{\/\w+(?=.joined)}).to_s()[1..-1]
  end

  def minecraft(log_line)
    log_line.match(/(?<=\bUUID\sof\splayer\s)(\w+)/).to_s()
  end
end
