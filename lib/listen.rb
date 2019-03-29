Thread.abort_on_exception = true
require "timers"
require "discordrb"
require "./lib/log_parser"
require "./lib/handlers/discord"

# Listen for events from Discord and systemd
module Listen
  def self.start
    @bot = Discordrb::Commands::CommandBot.new(token: ENV["TOKEN"], prefix: ENV["PREFIX"])
    @bot.ready { game_server_hooks() }
    @bot.run()
  end

  def self.game_server_hooks
    server = @bot.servers.dig(ENV["SERVER_ID"].to_i)
    games = { "starbound" => [], "rust" => [], "minecraft" => [] }
    parser = LogParser.new(games)
    timer = Timers::Group.new
    timer.now_and_every(15) { DiscordHelpers.game_announce(server, parser) }
    Thread.new { loop { timer.wait } }
  end
end
