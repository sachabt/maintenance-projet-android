extends Control

var base_mag := Vector3.ZERO

export var delay_between_attacks := 1.2
var player_pos = Directions.NONE
var attack_dir = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var score :=0
var streak :=0
var screen_size := Vector2.ZERO

onready var attack = preload("res://Attack.tscn")

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
	$AttackTimer.wait_time = delay_between_attacks
	$AttackTimer.start()
	$timeLeft.material.set_shader_param ("timer_value",  delay_between_attacks)


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
			player_pos = Directions.UP
		elif mag.y<base_mag.y:
			player_pos = Directions.DOWN


func move():
	$Player/ShieldArea2D.position = $Player.position
	var shield_offset = $Player.shield_offset
	match(player_pos):
		Directions.UP:
			$Player/ShieldArea2D.position.y -= shield_offset
		Directions.DOWN:
			$Player/ShieldArea2D.position.y += shield_offset
		Directions.RIGHT:
			$Player/ShieldArea2D.position.x += shield_offset
		Directions.LEFT:
			$Player/ShieldArea2D.position.x -= shield_offset


func _on_AttackTimer_timeout():
	attack_dir = Directions.values()[rng.randi()%4]
	var new_attack = attack.instance()
	new_attack.direction = attack_dir
	new_attack.position = screen_size/2
	new_attack.position -= (screen_size * attack_dir)/2
	add_child(new_attack)


func end_game():
	print("ded")
	$AttackTimer.stop()
	pass


func _on_Player_died():
	end_game()
