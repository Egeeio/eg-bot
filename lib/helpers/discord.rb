# frozen_string_literal: true
require "./lib/log_parser"

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
    @debug_channel ||= discord_channel(server, "debug")
  end

  def self.game_announce(server, games)
    log_parser = LogParser.new(games)
    players = log_parser.parse(games)
    return unless players.empty? == false

    players_string = players.join(",")
    channel = discord_channel(server, "starbound") # This needs to be factored, maybe into a map with an array of users for each game server
    msg = "**#{players_string}** have joined the server"
    channel.send_message(msg) unless check_last_message(channel, msg)
  end
end
