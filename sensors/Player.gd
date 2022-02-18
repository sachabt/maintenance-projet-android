extends Area2D

export var shield_offset := Vector2(50, 50)
export var life := 5
var score := 0
var streak := 0

signal died

func _ready():
	call_deferred("spawn")

func spawn():
	position = get_viewport().size /2

func move(direction):
	$ShieldArea2D.position = position
	print(str(direction))
	$ShieldArea2D.position += (direction * shield_offset)

func _on_ShieldArea2D_area_entered(area):
	area.queue_free()
	streak +=1
	score+= streak


func _on_Player_area_entered(area):
	area.queue_free()
	life-=1
	if life==0:
		emit_signal("died")
