# frozen_string_literal: true

require "yaml"
require "helpers"

# The module that contains and handles all events associated with Discord
module DiscordEvents
  extend Discordrb::EventContainer
  # Server event handler
  member_join do |event|
    DiscordHelpers.discord_channel(event.server, "general")
                  .send_message("#{event.user.username} just joined the server.")
  end

  member_leave do |event|
    DiscordHelpers.discord_channel(event.server, "general")
                  .send_message("#{event.user.username} just left the server.")
  end
end
