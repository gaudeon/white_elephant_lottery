extends "res://addons/gut/test.gd"

var LotteryPool = load("res://game/lib/LotteryPool.gd")
var lottery_pool = LotteryPool.new()

func test_lottery_pool():
	assert_true(lottery_pool.getCashAmountQty(20) == 0, "amount not recorded")

	lottery_pool.addCashAmount(20)

	assert_true(lottery_pool.getCashAmountQty(20) == 1, "amount recorded once")

	lottery_pool.addCashAmount(20)

	assert_true(lottery_pool.getCashAmountQty(20) == 2, "amount recorded twice")

	var cash_list = lottery_pool.getCashList()

	assert_true(cash_list.size() == 2, "cash list has the correct number of entries")
