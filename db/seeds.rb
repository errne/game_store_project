require_relative( "../models/tag.rb" )
require_relative( "../models/game.rb" )
require_relative( "../models/game_tag.rb" )
require_relative( "../models/developer.rb" )
require_relative( "../models/publisher.rb" )
require("pry-byebug")

# Game.delete_all()
# Developer.delete_all()
# Publisher.delete_all()
Tag.delete_all()

# developer1 = Developer.new({
#   "name" => "Obsidian",
#   "location" => "USA"
# })
#
# developer1.save()
#
# publisher1 = Publisher.new({
#   "name" => "Bethesda",
#   "location" => "USA"
# })
#
# publisher1.save()
#
# game1 = Game.new({
#   "name" => "New Vegas",
#   "developer_id" => 1,
#   "publisher_id" => 1,
#   "description" => "The best fallout game",
#   "stock_quantity" => 8,
#   "buying_cost" => 11,
#   "selling_price" => 20
# })
#
# game1.save()

tag1 = Tag.new({"name" => "RPG"})
tag2 = Tag.new({"name" => "Action"})
tag3 = Tag.new({"name" => "Adventure"})
tag4 = Tag.new({"name" => "Open-World"})

tag1.save
tag2.save
tag3.save
tag4.save

gameTag1 = GameTag.new({"game_id" => 1, "tag_id" => tag1.id})
gameTag1a = GameTag.new({"game_id" => 1, "tag_id" => tag4.id})
gameTag2 = GameTag.new({"game_id" => 2, "tag_id" => tag3.id})

gameTag1.save
gameTag1a.save
gameTag2.save
