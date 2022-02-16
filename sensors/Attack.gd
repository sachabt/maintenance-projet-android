extends Area2D

export var attack_speed := 50
export var direction := Vector2.ZERO

func _physics_process(delta):
	position += direction*attack_speed*delta
