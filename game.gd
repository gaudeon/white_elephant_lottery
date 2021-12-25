extends Node2D

var start_panel = preload("res://game/start.tscn").instance()
var setup_lottery_panel = preload("res://game/setup_lottery.tscn").instance()
var play_game_panel = preload("res://game/play_game.tscn").instance()
var player_lottery_entry_panel = preload("res://game/player_lottery_entry.tscn").instance()
var show_results_panel = preload("res://game/show_results.tscn").instance()
var amount_results_panel = preload("res://game/amount_results.tscn").instance()
var finish_panel = preload("res://game/finish.tscn").instance()

var mp3_1 = preload("res://assets/Christmas.mp3")
var mp3_2 = preload("res://assets/Present.mp3")
var mp3_3 = preload("res://assets/Merry.mp3")
var mp3_4 = preload("res://assets/First-Snow.mp3")

var lottery_pool = load("res://game/lib/LotteryPool.gd").new()
var player_lottery = load("res://game/lib/PlayerLottery.gd").new()
var players = load("res://game/lib/Players.gd").new()
var play_order = load("res://game/lib/PlayOrder.gd").new()

var current_player = ""
var cash_amount_list = []
var next_cash_amount = 0
var lottery_results = {}

var mp3_playlist = [
	mp3_1,
	mp3_2,
	mp3_3,
	mp3_4
]
var audio_player
var next_mp3_song

# Called when the node enters the scene tree for the first time.
func _ready():
	start_panel.get_node("Button").connect("pressed", self, "_on_setup_lottery")
	setup_lottery_panel.get_node("Button").connect("pressed", self, "_on_save_setup")
	play_game_panel.get_node("Button").connect("pressed", self, "_on_play_game")
	player_lottery_entry_panel.get_node("Button").connect("pressed", self, "_on_next_player")
	show_results_panel.get_node("Button").connect("pressed", self, "_on_show_results")
	amount_results_panel.get_node("Button").connect("pressed", self, "_on_amount_results")
	audio_player = get_node("AudioStreamPlayer")
	next_mp3()
	load_start_panel()

func _on_setup_lottery():
	unload_start_panel()
	load_setup_lottery()

func _on_save_setup():
	var cash_amounts_text = setup_lottery_panel.get_node("CashAmounts_LineEdit").text
	var players_text = setup_lottery_panel.get_node("Players_LineEdit").text
	var cash_amounts_ara = cash_amounts_text.split(",")
	var player_names_ara = players_text.split(",")
	for amt in cash_amounts_ara:
		lottery_pool.addCashAmount(amt)
	for ppl in player_names_ara:
		players.addName(ppl)
		play_order.addName(ppl)
	play_order.shuffleNames()
	player_lottery.setCashList(lottery_pool.getCashList())
	cash_amount_list = lottery_pool.getCashAmounts()
	unload_setup_lottery()
	load_play_game_panel()

func _on_play_game():
	unload_play_game_panel()
	current_player = play_order.getNextName()
	load_player_lottery_entry_panel()

func _on_next_player():
	var lottery_num = player_lottery_entry_panel.get_node("Number_LineEdit").text as int
	if (player_lottery.addNameAndLotteryNumber(current_player, lottery_num)):
		current_player = play_order.getNextName()
		if (current_player != null):
			unload_player_lottery_entry_panel()
			load_player_lottery_entry_panel()
		else:
			unload_player_lottery_entry_panel()
			lottery_results = player_lottery.runLottery()
			load_show_results_panel()
	else:
		player_lottery_entry_panel.get_node("Error_Text").text = player_lottery.last_add_name_error
		unload_player_lottery_entry_panel()
		load_player_lottery_entry_panel()

func _on_show_results():
	unload_show_results_panel()
	next_cash_amount = cash_amount_list.pop_front()
	load_amount_results_panel()

func _on_amount_results():
	next_cash_amount = cash_amount_list.pop_front()
	if (next_cash_amount == null):
		unload_amount_results_panel()
		load_finish_panel()
	else:
		unload_amount_results_panel()
		load_amount_results_panel()

func load_start_panel():
	add_child(start_panel)

func unload_start_panel():
	remove_child(start_panel)

func load_setup_lottery():
	setup_lottery_panel.get_node("CashAmounts_LineEdit").text = ""
	setup_lottery_panel.get_node("Players_LineEdit").text = ""
	add_child(setup_lottery_panel)

func unload_setup_lottery():
	remove_child(setup_lottery_panel)

func load_play_game_panel():
	add_child(play_game_panel)

func unload_play_game_panel():
	remove_child(play_game_panel)

func load_player_lottery_entry_panel():
	player_lottery_entry_panel.get_node("Number_LineEdit").text = ""
	player_lottery_entry_panel.get_node("Error_Text").text = ""
	player_lottery_entry_panel.get_node("PlayerLabel").text = current_player
	add_child(player_lottery_entry_panel)

func unload_player_lottery_entry_panel():
	remove_child(player_lottery_entry_panel)

func load_show_results_panel():
	add_child(show_results_panel)

func unload_show_results_panel():
	remove_child(show_results_panel)

func load_amount_results_panel():
	amount_results_panel.get_node("AmountLabel").text = next_cash_amount as String + " dollars"
	for player in lottery_results:
		if (lottery_results[player] as int == next_cash_amount):
			amount_results_panel.get_node("Names_Text").text += player + "\n"
	add_child(amount_results_panel)

func unload_amount_results_panel():
	amount_results_panel.get_node("AmountLabel").text = ""
	amount_results_panel.get_node("Names_Text").text = ""
	remove_child(amount_results_panel)

func load_finish_panel():
	add_child(finish_panel)

func next_mp3():
	next_mp3_song = mp3_playlist.pop_front()
	mp3_playlist.push_back(next_mp3_song)
	audio_player.set_stream(next_mp3_song)
	audio_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(audio_player.get_playback_position() >= next_mp3_song.get_length()-1):
		audio_player.stop()
		next_mp3()
