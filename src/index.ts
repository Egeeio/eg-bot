import Listen from "./lib/bot";

if (!process.env.TOKEN)
  throw new Error("Exiting - Double check your environment variables.");
Listen();
