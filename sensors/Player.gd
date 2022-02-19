extends Area2D

export var shield_offset := Vector2(50, 50)
export var life := 5
var score := 0
var streak := 0

signal died
var rng = RandomNumberGenerator.new()

func _ready():
	position = get_viewport().size /2
	rng.randomize()
	var i = rng.randi() % 8 + 1
	$playerAnimatedSprite.play("player_"+str(i))
	i = rng.randi() % 12
	$weaponArea2D/weaponSprite.frame = i

func move(direction):
	$weaponArea2D.look_at(direction)
	$weaponArea2D.position = Vector2.ZERO
	$weaponArea2D.position += (direction * shield_offset)
	$playerAnimatedSprite.flip_h = direction.x < 0

func _on_WeaponArea2D_area_entered(area):
	area.queue_free()
	streak +=1
	score+= streak


func _on_Player_area_entered(area):
	area.queue_free()
	life-=1
	if life==0:
		emit_signal("died")


func _on_weaponArea2D_area_entered(area):
	area.queue_free()
	pass # Replace with function body.
