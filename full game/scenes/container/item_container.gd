extends StaticBody2D
class_name ItemContainer
@onready var output : Marker2D = $Output

@onready var current_direction: Vector2 = Vector2.ZERO #.rotated(rotation)
var opened: bool = false
signal open(pos, direction)

