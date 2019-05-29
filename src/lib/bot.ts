import { Client } from "discord.js";

export default async function Listen() {
  const client = new Client();
  await client.login(process.env.TOKEN);
  console.log("prepare to YEET");
}
