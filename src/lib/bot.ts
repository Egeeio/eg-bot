import { Client} from "discord.js";
import { GetChannel, GetGuild, SendChannelMessage } from "./helpers";

export default async function Connect() {
  const client = new Client();
  await client.login(process.env.TOKEN);
  Listen(client);
}

async function Listen(client: Client) {
  const guild = await GetGuild(client, process.env.SERVER_ID!);
  client.on("guildMemberAdd", async (member) => {
    const general = await GetChannel(guild, "general");
    SendChannelMessage(general, `ya boy ${member.displayName} has joined up`);
  });
  client.on("guildMemberRemove", async (member) => {
    const debug = await GetChannel(guild, "he-man");
    SendChannelMessage(debug, `**${member.displayName}** just bailed`);
  });
}
