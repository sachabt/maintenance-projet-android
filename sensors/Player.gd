extends Area2D

export var shield_offset := 200
export var life := 5
var score := 0
var streak := 0

signal died

func _ready():
	position = get_viewport().size

func _on_ShieldArea2D_area_entered(area):
	area.queue_free()
	streak +=1
	score+= streak


func _on_Player_area_entered(area):
	area.queue_free()
	life-=1
	if life==0:
		emit_signal("died")
