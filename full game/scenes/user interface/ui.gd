extends CanvasLayer

# colors
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9,0,0,1)

var gamecam : Camera2D
var currcam : Camera2D

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar
@onready var minimap := %TextureRectMinimap
@onready var cam2dmap : Camera2D = %Camera2DMinimap
@onready var sub_viewport = $SubViewport
@onready var vp = get_viewport()
@onready var vpsize : Vector2 = vp.get_visible_rect().size
@onready var tilemap : TileMap = get_parent().get_node("Ground/TileMap")


func _ready():
	Globals.connect("stat_change", update_stat_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
	await RenderingServer.frame_post_draw
	vpsize = vp.get_visible_rect().size

	
	cam2dmap.position = vp.get_visible_rect().get_center()
#	var vptx = vp.get_texture()
	gamecam = vp.get_camera_2d()
	currcam = gamecam
	print(tilemap.get_used_rect().size * tilemap.tile_set.tile_size)
#	var tex = cam2d.get_
#	var MapTex := get_viewport().get_texture().get_image()
	sub_viewport.world_2d = vp.world_2d
	sub_viewport.size = vp.size * 1.2
	minimap.texture = sub_viewport.get_texture()

func _process(_delta):
	if Globals.fullscreenmapactive:
		gamecam.zoom = Vector2(0.6, 0.6)
		gamecam.global_position = Vector2(0,0) # get_parent().get_node("Ground").global_position
		vp.content_scale_size = tilemap.get_used_rect().size * tilemap.tile_set.tile_size
		vp.size = vpsize
#		vp.size = tilemap.get_used_rect().size * tilemap.tile_set.tile_size
	else:
		vp.content_scale_size = vpsize
		vp.size = vpsize

	cam2dmap.global_position = vp.get_camera_2d().global_position
	
	pass


func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)

func update_health_text():
	health_bar.value = Globals.health

func update_stat_text():
	update_laser_text()
	update_grenade_text()
	update_health_text()

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green

