extends "res://addons/gut/test.gd"

var Players = load("res://game/lib/Players.gd")
var players = Players.new()

func test_names():
	assert_true(players.hasName("George") == false, "name not recorded")
	
	players.addName("George")
	
	assert_true(players.hasName("George") == true, "name recorded")
	
	var names_size_before = players.getNames().size()
	
	players.addName("George")
	
	var names_size_after = players.getNames().size()
	
	assert_true(names_size_before == names_size_after, "names remain unique in players")
	
	players.addName("George 1")
	
	var george_player_id = players.getNameId("George")
	
	var george_1_player_id = players.getNameId("George 1")
	
	assert_true(george_player_id == 0 && george_1_player_id, "names have correct associated idss")
