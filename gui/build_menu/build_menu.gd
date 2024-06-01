extends Control

@onready var placeholder = $Panel/ScrollContainer/VBoxContainer/placeholder
@onready var anim = $AnimationPlayer

var opened = false

var count = -1
var inside = [] 

var coords = {
	Vector2i(11,2):"Shaded Box",
	Vector2i(7,4):"Top Left Grass",
	Vector2i(8,4):"Top Middle Grass",
	Vector2i(9,4):"Top Right Grass",
	Vector2i(7,5):"Left Middle Grass",
	Vector2i(8,5):"Middle Middle Grass",
	Vector2i(9,5):"Right Middle Grass",
	Vector2i(7,6):"Left Bottom Grass",
	Vector2i(8,6):"Middle Bottom Grass",
	Vector2i(9,6):"Right Bottom Grass",
	Vector2i(8,3):"BOX"
}

var texture_path = {
	"Shaded Box":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0051.png",
	"Top Left Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0087.png",
	"Top Middle Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0088.png",
	"Top Right Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0089.png",
	"Left Middle Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0107.png",
	"Middle Middle Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0108.png",
	"Right Middle Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0109.png",
	"Left Bottom Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0127.png",
	"Middle Bottom Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0128.png",
	"Right Bottom Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0129.png",
	"Wooden Crate":"res://temp_art/button/wooden.png",
	"Pressure Plate":"res://sprites/single/button-single.png",
	"Fan":"res://sprites/single/fan-build.png",
	"BOX":"res://sprites/box.png",
	"Lever":"res://sprites/single/lever_build.png"
}



func _ready():
	Global.build_menu = self

func remove_me():
	opened = false
	anim.play_backwards("open")

func add_tile(received_coords):
	var tile_name = coords[received_coords]
	var texture_to_load = load(texture_path[tile_name])
	var texture_rec = TextureRect.new()
	count += 1
	inside.append(tile_name)
	texture_rec.texture = texture_to_load
	texture_rec.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	texture_rec.gui_input.connect(_on_gui_input.bind(tile_name))
	$Panel/ScrollContainer/VBoxContainer.add_child(texture_rec)
	$Panel/ScrollContainer/VBoxContainer.move_child(placeholder,-1)

func add_mechanic(mechanic_name):
	var texture_to_load = load(texture_path[mechanic_name])
	var texture_rec = TextureRect.new()
	count += 1
	inside.append(mechanic_name)
	texture_rec.texture = texture_to_load
	texture_rec.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	texture_rec.gui_input.connect(_on_gui_input_mech.bind(mechanic_name))
	$Panel/ScrollContainer/VBoxContainer.add_child(texture_rec)
	$Panel/ScrollContainer/VBoxContainer.move_child(placeholder,-1)
	
func _on_gui_input_mech(event:InputEvent,mech_name):
	if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				if Global.check_constraints(mech_name)==false:
					Global.reset_build_menu()
					return
				Global.draw_me_mechanic(mech_name)
				remove_child_(mech_name)

func _on_gui_input(event:InputEvent,tile_name):
	if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				Global.draw_me(tile_name)
				remove_child_(tile_name)

func remove_child_(tile_name):
	var index = index_finder(tile_name)
	var child = $Panel/ScrollContainer/VBoxContainer.get_child(index)
	child.queue_free()
	count -= 1
	inside.remove_at(index)

func index_finder(tile_name):
	for i in range(inside.size()):
		if inside[i] == tile_name:
			return i
	return -1
	
func _input(event):
	if Input.is_action_pressed("escape"):
		if opened:
			_on_cancel_pressed()

func _on_cancel_pressed():
	Global.cancel_build()
	opened = false
	anim.play_backwards("open")
	#self.queue_free()

func _on_obj_8_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me_mechanic("fan")
