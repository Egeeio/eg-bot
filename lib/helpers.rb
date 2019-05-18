# frozen_string_literal: true

# Assorted helper methods
module DiscordHelpers
  def self.debug_notification(server, message)
    puts message
    debug_channel(server).send_message(message)
  end

  def self.discord_channel(server, channel_name)
    server.channels.select { |x| x.name == channel_name }.first
  end

  def self.check_last_message(channel, msg)
    channel.history(1).first.content.include?(msg)
  end

  def self.delete_last_message(channel)
    channel.history(1).first.delete
  end

  def self.debug_channel(server)
    discord_channel(server, "debug")
  end

  def self.misc_games_channel(server)
    discord_channel(server, "misc-games")
  end
end
