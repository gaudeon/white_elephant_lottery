extends "res://addons/gut/test.gd"

var PlayOrder = load("res://game/lib/PlayOrder.gd")
var play_order = PlayOrder.new()

func test_player_order():
	var names = ["abe", "bill", "charles", "dave", "ed"]

	for name in names:
		play_order.addName(name)
	
	play_order.shuffleNames()

	assert_true(
			play_order.getNextName() != names[0] ||
			play_order.getNextName() != names[1] ||
			play_order.getNextName() != names[2] ||
			play_order.getNextName() != names[3] ||
			play_order.getNextName() != names[4],
			"names are shuffled")
