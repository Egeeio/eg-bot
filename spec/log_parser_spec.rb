require "./lib/log_parser"

RSpec.describe LogParser, "uhh" do
  context "uhhhh" do
    it "uhhh does something" do
      games = { "starbound" => [], "rust" => [], "minecraft" => [] }
      log_parser = LogParser.new(games)
      log_parser.parse()
      puts log_parser.players
    end
  end
end
