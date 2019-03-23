Thread.abort_on_exception = true
require "yaml"
require "timers"
require "docker"
require "discordrb"
require "./lib/listeners/generic"
require "./lib/handlers/discord"

# Listen for events from Discord and systemd
class Listen
  def initialize
    @timers = Timers::Group.new
    @bot = Discordrb::Commands::CommandBot.new(token: ENV["TOKEN"], prefix: ENV["PREFIX"])
    @bot.include!(DiscordEvents)
  end

  def start
    @bot.ready do |event|
      event.bot.game = YAML.load_file("./config.yml")["games"].sample()
      game_loop()
    end
    @bot.run()
  end

  private

  def game_loop
    @timers.now_and_every(30) do
      GenericListener.listen(@bot, "rust", %r{\/\w+(?=.joined)})
      GenericListener.listen(@bot, "minecraft", /(?<=\bUUID\sof\splayer\s)(\w+)/)
    end
    Thread.new { loop { @timers.wait } }
  end
end
