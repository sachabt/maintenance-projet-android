extends Control

onready var attack = preload("res://Ennemy.tscn")
export var spawn_offset = Vector2.ZERO
var base_mag := Vector3.ZERO

export var delay_between_attacks := 1.2
var player_pos = Directions.NONE
var attack_dir = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var screen_size := Vector2.ZERO


var pattern = File.new()
var pattern_index := 0

const Directions = {
	'RIGHT' : Vector2.RIGHT,
	'LEFT' : Vector2.LEFT, 
	'UP' : Vector2.UP, 
	'DOWN' : Vector2.DOWN, 
	'NONE' : Vector2.ZERO
}

func _ready():
	base_mag = Input.get_magnetometer()
	screen_size = get_viewport().size
	spawn_offset = Vector2(screen_size.x/10, screen_size.y/5)
	$AttackTimer.wait_time = delay_between_attacks
	$AttackTimer.start()
	
	pattern.open("res://pattern.json", File.READ)


func _process(delta):
	# Get our data
	var mag = Input.get_magnetometer()
	if abs(mag.x)>abs(mag.y):
		if mag.x>base_mag.x:
			player_pos = Directions.LEFT
		elif mag.x<base_mag.x:
			player_pos = Directions.RIGHT
	else:
		if mag.y>base_mag.y:
			player_pos = Directions.DOWN
		elif mag.y<base_mag.y:
			player_pos = Directions.UP
			
	$Player.move(player_pos)


func _on_AttackTimer_timeout():
	print("argh")
	attack_dir = Directions.values()[rng.randi()%4]
	var new_attack = attack.instance()
	new_attack.direction = attack_dir
	new_attack.position = screen_size/2
	new_attack.position -= (screen_size * attack_dir)/2 - spawn_offset*attack_dir
	add_child(new_attack)

func set_text(text):
	$Score.text = text

func add_score():
	var save_game = File.new()
	save_game.open("user://scores.save", File.READ_WRITE)
	save_game.seek_end()
	var score = {OS.get_ticks_msec() : $Player.score}
	save_game.store_line(to_json(score))
	

	save_game.close()

func _on_Player_died():
	add_score()
	assert(get_tree().change_scene("res://MainMenu.tscn")==OK)
