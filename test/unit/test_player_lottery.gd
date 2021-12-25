extends "res://addons/gut/test.gd"

var PlayerLottery = load("res://game/lib/PlayerLottery.gd")
var player_lottery = PlayerLottery.new()

func test_player_lottery_numbers():
	assert_true(player_lottery.addNameAndLotteryNumber("Oliver", 3) == false, "name and lottery number not added")

	player_lottery.setCashList([5,5,10,10,20])
	
	var EXPECTED_CASH_SUM = 50

	assert_true(player_lottery.getCashList().size() == 5, "cash list is correct size")

	assert_true(player_lottery.addNameAndLotteryNumber("Oliver", 3) == true, "name and lottery number added for first name")

	assert_true(player_lottery.addNameAndLotteryNumber("Oliver", 1) == false, "name already used correctly")

	assert_true(player_lottery.addNameAndLotteryNumber("Quinlee", 3) == false, "lottery number already used correctly")

	assert_true(player_lottery.addNameAndLotteryNumber("Quinlee", 1) == true, "name and lottery number added for second name")

	assert_true(player_lottery.addNameAndLotteryNumber("Chelsey", 2) == true, "name and lottery number added for third name")

	assert_true(player_lottery.addNameAndLotteryNumber("Robert", 4) == true, "name and lottery number added for fourth name")

	assert_true(player_lottery.addNameAndLotteryNumber("Kaylin", 0) == true, "name and lottery number added for fifth name")

	var lottery_results = player_lottery.runLottery()

	assert_true(lottery_results.keys().size() == 5, "lottery results returned")

	var cash_sum = 0
	for v in lottery_results.values():
		cash_sum += v

	assert_true(cash_sum == EXPECTED_CASH_SUM, "lottery results are correct")
