extends Control

export var game_scene := "res://game.tscn"
export var score_scene := ""

func _on_start_pressed():
	change_scene(game_scene)

func _on_score_pressed():
	change_scene(score_scene)

func change_scene(scene):
	assert(get_tree().change_scene(scene)==OK)
	
func _on_quit_pressed():
	get_tree().quit()
