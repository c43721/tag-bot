import { Client, Registry } from "@skyra/http-framework";

const client = new Client({
  discordPublicKey: process.env.DISCORD_PUBLIC_KEY!,
});

const registry = new Registry({});

// Load all the commands and message component handlers:
await client.load();

await registry.registerAllCommandsInGuild(process.env.GUILD_ID!);

// Start up the HTTP server;
await client.listen({ port: 3000 });
