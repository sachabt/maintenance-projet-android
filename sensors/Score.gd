extends Control

func _ready():
	load_score()

func load_score():
	var save_game = File.new()
	if not save_game.file_exists("user://scores.save"):
		return # Error! We don't have a save to load.
	
	save_game.open("user://scores.save", File.READ)
	
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		node_data.values()

		for i in node_data.keys():
			$Scores.text += str(node_data[i])+"\n"

	save_game.close()


func _on_Button_pressed():
	assert(get_tree().change_scene("res://MainMenu.tscn")==OK)
