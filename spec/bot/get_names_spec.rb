# frozen_string_literal: true

require "bot"

RSpec.describe "get_names function" do
  it "returns a list of names" do
    file_path = "conf/config.yml"
    names = Bot.get_names(file_path)
    expect(names).not_to be_empty
  end
end
