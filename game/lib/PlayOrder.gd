extends Reference

class_name PlayOrder

var names = [];
var shuffled = [];

func _init():
	pass

func addName(name) -> void:
	names.push_back(name)

func shuffleNames() -> void:
	shuffled = names.duplicate()
	shuffled.shuffle()
	shuffled.shuffle()
	shuffled.shuffle()

func getNextName() -> String:
	return shuffled.pop_front()

func resetNames() -> void:
	self.shuffleNames()
