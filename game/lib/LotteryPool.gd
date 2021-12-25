extends Reference

class_name LotteryPool

var cash_amounts = {}

# Called when the node enters the scene tree for the first time.
func _init():
	pass

func addCashAmount(amount) -> void:
	var i_amount = amount as int
	if (!cash_amounts.has(i_amount)):
		cash_amounts[i_amount] = 1
	else:
		cash_amounts[i_amount] = cash_amounts[i_amount] + 1

func getCashAmountQty(amount) -> int:
	if (!cash_amounts.has(amount)):
		return 0
	else:
		return cash_amounts[amount]

func getCashAmounts() -> Array:
	var cash_amount_list = cash_amounts.keys()
	cash_amount_list.sort()
	return cash_amount_list

func getCashList() -> Array:
	var cash_list = []

	for amount in cash_amounts:
		for x in range(cash_amounts[amount]):
			cash_list.push_back(amount)

	cash_list.sort()

	return cash_list

