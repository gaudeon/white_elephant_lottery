extends Reference

class_name PlayerLottery

var cash_list = []
var player_list = {}
var last_add_name_error = ""

# Called when the node enters the scene tree for the first time.
func _init():
	pass # Replace with function body.

func setCashList(cash_amounts) -> void:
	cash_amounts.sort()
	cash_list = cash_amounts

func getCashList() -> Array:
	return cash_list

func addNameAndLotteryNumber(name, lottery_number) -> bool:
	var i_lottery_number = lottery_number as int

	if (player_list.has(name)):
		last_add_name_error = "player already exists"
		return false

	if (player_list.values().find(i_lottery_number) >= 0):
		last_add_name_error = "lottery number already used"
		return false

	if (cash_list.size() == 0):
		last_add_name_error = "cash list not set"
		return false

	if (cash_list.size() <= player_list.keys().size()):
		last_add_name_error = "all players assigned a number"
		return false

	if (i_lottery_number < 0 || i_lottery_number >= cash_list.size()):
		last_add_name_error = "number is outside the lottery number range"
		return false

	player_list[name] = i_lottery_number

	return true

func runLottery() -> Array:
	var shuffled_cash = cash_list.duplicate()
	shuffled_cash.shuffle()
	shuffled_cash.shuffle()
	shuffled_cash.shuffle()

	var lottery_results = {}

	for player in player_list:
		lottery_results[player] = shuffled_cash[player_list[player]]

	return lottery_results
