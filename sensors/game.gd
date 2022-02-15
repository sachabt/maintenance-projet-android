extends Control

var base_mag := Vector3.ZERO
export var life := 5
export var delay_between_attacks := 1.2
var player_pos = Directions.NONE
var attack_pos = Directions.NONE
var rng = RandomNumberGenerator.new()

var score :=0
var streak :=0

enum Directions{
	RIGHT, LEFT, UP, DOWN, NONE
}

func _ready():
	base_mag = Input.get_magnetometer()
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
	
	move()
	
	if life <= 0:
		end_game()

func move():
	match(player_pos):
		Directions.UP:
			$ColorRect.color = Color.red
		Directions.DOWN:
			$ColorRect.color = Color.blue
		Directions.RIGHT:
			$ColorRect.color = Color.green
		Directions.LEFT:
			$ColorRect.color = Color.yellow


func check_player_pos():
	if(player_pos != attack_pos):
		life-=1
	else:
		streak +=1
		score+= streak

func _on_AttackTimer_timeout():
	check_player_pos()
	attack_pos = Directions.get(rng.randi()%4)

func end_game():
	$AttackTimer.stop()
	
	pass
