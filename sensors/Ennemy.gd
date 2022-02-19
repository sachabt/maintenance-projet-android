extends Area2D

export var attack_speed := 50
export var direction := Vector2.ZERO

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var i = rng.randi() % 8 + 1
	$EnnemyAnimatedSprite2.play("ennemy_"+str(i))

func _physics_process(delta):
	position += direction*attack_speed*delta
