import { Client, Guild, TextChannel } from "discord.js";

export async function GetGuild(discordClient: Client, guildId: string) {
    const guild = await discordClient.guilds.get(guildId)!;
    return guild;
  }

export async function GetChannel(guild: Guild, channelName: string) {
    const channel = await guild.channels.find((chan) => chan.name === channelName);
    return channel as TextChannel;
  }
