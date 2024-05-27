extends TileMap

var canvas_layer
var mouse
var player

var indicator = preload("res://gui/tile_selector/tile_selector.tscn")
var build_menu = preload("res://gui/build_menu/build_menu.tscn")

var mouse_pos:Vector2
var tile_pos:Vector2i
var previous_tile_pos:Vector2i

var locked_tile_pos:Vector2i
var is_locked = false
var can_build = false

var range = Vector2i(3,3) #inclusive

func _ready():
	Global.current_tilemap = self
	pass

func is_inside_range(pos):
	var player_pos = local_to_map(player.global_position)
	if (pos.x <= player_pos.x + range.x and pos.x >= player_pos.x - range.x) and (pos.y <= player_pos.y + range.y and pos.y >= player_pos.y - range.y):
		return true
	else:
		return false

func _process(delta):
	if !is_locked:
		tile_pos = local_to_map(get_global_mouse_position())
		if is_inside_range(tile_pos):
			can_build = true
			if tile_pos != previous_tile_pos or previous_tile_pos == null:
				erase_cell(1,previous_tile_pos)
				set_cell(1,tile_pos,2,Vector2i(0,0),1)
		else:
			can_build = false
			erase_cell(1,previous_tile_pos)
		previous_tile_pos = tile_pos
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and is_locked == false and can_build:
			is_locked = true
			locked_tile_pos = tile_pos
			var ins = build_menu.instantiate()
			canvas_layer.add_child(ins)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse.hide()
			


func place_block(vect:Vector2i):
	var player_pos  = local_to_map(player.global_position)
	var player_up_pos = Vector2i(player_pos.x,player_pos.y-1)
	if player_pos == tile_pos or player_up_pos == tile_pos:
		release()
		return
	set_cell(0,tile_pos,0,vect,0)
	release()

func release():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	mouse.show()
	is_locked = false
