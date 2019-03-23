require "./lib/helpers/discord"
require "./lib/helpers/container"

@regex = {
  "rust" => %r{\/\w+(?=.joined)},
  "minecraft" => /(?<=\bUUID\sof\splayer\s)(\w+)/
}

# Comment
module GenericListener
  def self.listen(bot, game)
    channel = DiscordHelpers.discord_channel(bot.servers.dig(ENV["SERVER_ID"].to_i), game)
    DiscordHelpers.game_announce(@regex[game], channel)
  end
end
