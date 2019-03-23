require "./lib/helpers/discord"

# Comment
module GenericListener
  @regex = {
    "rust" => %r{\/\w+(?=.joined)},
    "minecraft" => /(?<=\bUUID\sof\splayer\s)(\w+)/
  }
  def self.listen(bot, game)
    channel = DiscordHelpers.discord_channel(bot.servers.dig(ENV["SERVER_ID"].to_i), game)
    DiscordHelpers.game_announce(@regex[game], channel, game)
  end
end
