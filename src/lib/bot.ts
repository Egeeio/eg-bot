import { Client} from "discord.js";
import { GetChannel, GetGuild } from "./helpers";

export default async function Listen() {
  const client = new Client();
  await client.login(process.env.TOKEN);
  const guild = await GetGuild(client, "561304574917607424");
  const generalChannel = await GetChannel(guild, "general");
  generalChannel.send("<3 bob");
}
