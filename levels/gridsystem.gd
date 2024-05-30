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
var can_destroy_current_block = false
var can_grab_current_block = false

var range_for_build = Vector2i(3,3) #inclusive
var range_for_movement = Vector2i(1,4)
var reach = false

func _ready():
	Global.current_tilemap = self
	pass

func is_inside_range(pos,range):
	var player_pos = local_to_map(player.global_position)
	if (pos.x <= player_pos.x + range.x and pos.x >= player_pos.x - range.x) and (pos.y <= player_pos.y + range.y and pos.y >= player_pos.y - range.y):
		return true
	else:
		return false

func _process(delta):
	if !is_locked:
		tile_pos = local_to_map(get_global_mouse_position())
		if is_inside_range(tile_pos,range_for_build):
			reach = true
			if player.current_hammer == 1:
				if tile_pos != previous_tile_pos or previous_tile_pos == null:
					if get_cell_tile_data(0,tile_pos) == null:
						erase_cell(1,previous_tile_pos)
						set_cell(1,tile_pos,2,Vector2i(0,0),1)
						can_build = true
					elif get_cell_tile_data(0,tile_pos) != null:
						erase_cell(1,previous_tile_pos)
						can_build = false
			if player.current_hammer == 2:
				if tile_pos != previous_tile_pos or previous_tile_pos == null:
					if get_cell_tile_data(0,tile_pos) != null:
						erase_cell(1,previous_tile_pos)
						set_cell(1,tile_pos,2,Vector2i(0,0),1)
						can_destroy_current_block = get_cell_tile_data(0,tile_pos).get_custom_data("destructable")
					elif get_cell_tile_data(0,tile_pos) == null:
						erase_cell(1,previous_tile_pos)
						can_destroy_current_block = false
			reach = false
			if is_inside_range(tile_pos,range_for_movement):
				reach = true
				if player.current_hammer == 0:
					if tile_pos != previous_tile_pos or previous_tile_pos == null:
						if get_cell_tile_data(0,tile_pos) != null:
							erase_cell(1,previous_tile_pos)
							set_cell(1,tile_pos,2,Vector2i(0,0),1)
							can_grab_current_block = get_cell_tile_data(0,tile_pos).get_custom_data("destructable")
						elif get_cell_tile_data(0,tile_pos) == null:
							erase_cell(1,previous_tile_pos)
							can_grab_current_block = false
			elif player.current_hammer == 0:
				erase_cell(1,previous_tile_pos)
		else:
			reach = false
			can_build= false
			can_destroy_current_block = false
			can_grab_current_block = false
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
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and is_locked == false and can_destroy_current_block:
			set_cell(0,tile_pos,2,Vector2i(0,0),-1)
			can_destroy_current_block = false
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and is_locked == false and can_grab_current_block:
			player.grabbed = true
			if player.global_position.x < get_global_mouse_position().x:
				player.global_position.x = get_global_mouse_position().x -17
			if player.global_position.x > get_global_mouse_position().x:
				player.global_position.x = get_global_mouse_position().x +17
			player.hammer.set_fixed_pos()
			can_grab_current_block = false
			
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

func reset_everything():
	reach = false
	erase_cell(1,previous_tile_pos)
	can_build = false
	can_destroy_current_block = false
	can_grab_current_block = false
	is_locked = false
