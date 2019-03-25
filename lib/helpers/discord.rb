# frozen_string_literal: true

# Assorted helper methods
module DiscordHelpers
  # @param server [Discordrb::Server]
  # @param message [String]
  def self.debug_notification(server, message)
    puts message
    debug_channel(server).send_message(message)
  end

  # @param server [Discordrb::Server]
  # @param channel_name [String]
  # @return [Discordrb::Channel]
  def self.discord_channel(server, channel_name)
    server.channels.select { |x| x.name == channel_name }.first
  end

  # Checks latest message for a given Discord channel
  # and returns true or false if messages match
  #
  # @param channel [Discordrb::Channel]
  # @param msg [String]
  # @return [true, false]
  def self.check_last_message(channel, msg)
    channel.history(1).first.content.include?(msg)
  end

  # @param channel [Discordrb::Channel]
  def self.delete_last_message(channel)
    channel.history(1).first.delete
  end

  # @param server [Discordrb::Server]
  # @return [Discordrb::Channel]
  def self.debug_channel(server)
    @debug_channel ||= discord_channel(server, 'server-debug')
  end

  def self.game_announce(channel, game)
    log = `journalctl --since "30 seconds ago" --no-pager -u #{game}`
    players = []
    if game == "starbound"
      log.each_line do |line|
        match = line.match(/(['])(?:(?=(\\?))\2.)*?\1/) if line.include?(") connected")
        players.push(match)
      end
      # puts "matched" + players.to_s
    end
    puts players.to_s
    return unless players.empty? == false

    # player_name = if match.to_s[0] == "/" # This is a hack because I hate and suck at Regex
    #                 match.to_s[1..-1]
    #               else
    #                 match.to_s
    #               end
    # msg = "**#{player_name}** joined the server"
    # puts msg
    # channel.send_message(msg) unless check_last_message(channel, msg)
  end
end
