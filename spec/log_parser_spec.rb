require "./lib/log_parser"

RSpec.describe "Log Parser" do
  context "When matches are found" do
    it "Adds them to the array" do
      games = { "starbound" => [], "rust" => [] }
      log_parser = LogParser.new(games)
      log_parser.parse()
      expect(log_parser.players.first).not_to be_empty
    end
  end
end
