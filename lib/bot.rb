# frozen_string_literal: true

require "yaml"

Thread.abort_on_exception = true
require "timers"
require "discordrb"
require "./lib/handlers/discord"

# Listen for events from Discord and systemd
module Bot
  def self.connect
    bot = Discordrb::Commands::CommandBot.new(token: ENV["TOKEN"], prefix: ENV["PREFIX"])
    bot.ready { bootstrap(bot) }
    bot.run()
  end

  def self.bootstrap(bot)
    game_server_hooks(bot.servers.values.first())
  end

  def self.game_server_hooks(server)
    timer = Timers::Group.new
    timer.now_and_every(15) do
      DiscordHelpers.game_announce(server,
                                   game_list(get_names("#{File.dirname(__FILE__)}/../conf/gsd.yml")))
    end
    Thread.new { loop { timer.wait } }
  end

  def self.get_names(file_path)
    YAML.safe_load(File.read(file_path))["games"].keys
  end

  def self.game_list(games_hash)
    games = []
    games_hash.each do |game|
      games.push(game)
    end
    games
  end
end
