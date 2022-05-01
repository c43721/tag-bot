import { Command, RegisterCommand } from "@skyra/http-framework";

@RegisterCommand((builder) =>
  builder.setName("create").setDescription("creates a tag")
)
export default class CreateCommand extends Command {
  async chatInputRun() {
    return this.message({ content: "hello, world!" });
  }
}
