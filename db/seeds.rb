require_relative( "../models/game.rb" )
require_relative( "../models/developer.rb" )
require_relative( "../models/publisher.rb" )
require("pry-byebug")

# Game.delete_all()
# Developer.delete_all()
# Publisher.delete_all()

developer1 = Developer.new({
  "name" => "Obsidian",
  "location" => "USA"
})

developer1.save()

publisher1 = Publisher.new({
  "name" => "Bethesda",
  "location" => "USA"
})

publisher1.save()
