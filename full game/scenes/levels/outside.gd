extends LevelParent

@onready var gamecam : Camera2D = get_viewport().get_camera_2d()

func _process(_delta):
		if !Globals.fullscreenmapactive:
			gamecam.zoom = Vector2(0.6, 0.6)
			gamecam.global_position = gamecam.get_parent().global_position

func _on_gate_player_entered_gate(_body):
	var tween = get_tree().create_tween()
	tween.tween_property($Player,"speed",0,0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(camera,"zoom",Vector2(1,1),1).set_trans(Tween.TRANS_QUAD)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", Vector2(0.6,0.6),2)

