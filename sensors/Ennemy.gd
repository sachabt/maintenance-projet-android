extends Area2D

export var attack_speed := Vector2(150, 50)
export var direction := Vector2.ZERO

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var i = rng.randi() % 8 + 1
	$EnnemyAnimatedSprite.play("ennemy_"+str(i))
	$EnnemyAnimatedSprite.flip_h = direction == Vector2.LEFT

func _physics_process(delta):
	position += direction*attack_speed*delta
