require "./lib/helpers/discord"
require "./lib/log_parsers/starbound"

# Comment
module GenericListener
  def self.listen(bot, game)
    channel = DiscordHelpers.discord_channel(bot.servers.dig(ENV["SERVER_ID"].to_i), game)
    DiscordHelpers.game_announce(channel, game)
  end
end
