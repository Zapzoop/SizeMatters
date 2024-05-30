extends Control

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
	Vector2i(9,6):"Right Bottom Grass"
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
	"Right Bottom Grass":"res://kenney_1-bit-platformer-pack/Tiles/Transparent/tile_0129.png"
}

func _ready():
	$AnimationPlayer.play("open")
	Global.build_menu = self

func remove_me():
	$AnimationPlayer.play("close")

func add_tile(received_coords):
	var tile_name = coords[received_coords]
	var texture_to_load = load(texture_path[tile_name])
	var texture_rec = TextureRect.new()
	texture_rec.texture = texture_rec

func _input(event):
	if Input.is_action_pressed("escape"):
		_on_cancel_pressed()

func _on_cancel_pressed():
	Global.cancel_build()
	self.queue_free()

func _on_obj_8_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me_mechanic("fan")
