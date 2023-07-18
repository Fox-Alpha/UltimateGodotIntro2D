extends ItemContainer

@onready var label = $Label

var mouseover : bool = false

func hit():
	if not opened:
		$LidSprite.hide()
		$AudioStreamPlayer2D.play()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, output.global_position)
		opened = true
		label.visible = false
		mouseover = false

func _on_mouse_entered():
	if not opened:
		label.visible = true
		mouseover = true


func _on_mouse_exited():
	if not opened:
		label.visible = false
		mouseover = false

func _unhandled_input(event : InputEvent):
	if mouseover:
		if event.is_action_pressed("interact"):
			hit()
