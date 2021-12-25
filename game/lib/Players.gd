extends Reference

class_name Players

var names = []

func _init():
	pass

func hasName(name) -> bool:
	return self.getNameId(name) >= 0

func addName(name) -> void:
	if (!self.hasName(name)):
		names.append(name)

func getNames() -> Array:
	return names;

func getNameId(name) -> int:
	return names.find(name)
