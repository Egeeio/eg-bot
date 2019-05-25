# frozen_string_literal: true

require "discordrb"
require "commands"
require "events"

# Listen for events from Discord and systemd
module Bot
  def self.listen
    bot = Discordrb::Commands::CommandBot.new(token: ENV["BOT_TOKEN"], prefix: ENV["PREFIX"])
    bot.include! DiscordEvents
    bot.include! DiscordCommands
    bot.ready { bootstrap() }
    bot.run()
  end

  def self.bootstrap
    puts "prepare to yeet"
  end
end
