extends Node

var build_menu
var current_tilemap

var current_level

var player

var craftable_coords = {
	"Shaded Box":Vector2i(11,2),
	"Top Left Grass":Vector2i(7,4),
	"Top Middle Grass":Vector2i(8,4),
	"Top Right Grass":Vector2i(9,4),
	"Left Middle Grass":Vector2i(7,5),
	"Middle Middle Grass":Vector2i(8,5),
	"Right Middle Grass":Vector2i(9,5),
	"Left Bottom Grass":Vector2i(7,6),
	"Middle Bottom Grass":Vector2i(8,6),
	"Right Bottom Grass":Vector2i(9,6)
	}

func draw_me(string):
	current_tilemap.place_block(craftable_coords[string])
	build_menu.remove_me()

func draw_me_mechanic(string):
	var pos = current_tilemap.tile_pos
	var global_pos = current_tilemap.map_to_local(pos)
	current_level.attach_mechanic(string,global_pos)
	current_tilemap.release()

func cancel_build():
	current_tilemap.release()

func reset_build_menu():
	current_tilemap.reset_everything()
	build_menu.remove_me()
	current_tilemap.release()

func check_constraints(mech_name):
	var pos = current_tilemap.tile_pos
	match mech_name:
		"Fan":
			var left_one = Vector2i(pos.x - 1,pos.y)
			var right_one = Vector2(pos.x + 1,pos.y)
			if current_tilemap.get_cell_tile_data(0,left_one) == null and current_tilemap.get_cell_tile_data(0,right_one) == null:
					return false
			elif current_tilemap.get_cell_tile_data(0,left_one) != null and current_tilemap.get_cell_tile_data(0,right_one) == null:
				var left_side_block_value = current_tilemap.get_cell_tile_data(0,left_one).get_custom_data("can_attach")
				if left_side_block_value == true:
					return true
				else:
					return false
			elif current_tilemap.get_cell_tile_data(0,left_one) == null and current_tilemap.get_cell_tile_data(0,right_one) != null:
				var right_side_block_value = current_tilemap.get_cell_tile_data(0,right_one).get_custom_data("can_attach")
				if right_side_block_value == true:
					return true
				else:
					return false
			elif current_tilemap.get_cell_tile_data(0,left_one) != null and current_tilemap.get_cell_tile_data(0,right_one) != null:
				var left_side_block_value = current_tilemap.get_cell_tile_data(0,left_one).get_custom_data("can_attach")
				var right_side_block_value = current_tilemap.get_cell_tile_data(0,right_one).get_custom_data("can_attach")
				if left_side_block_value == false and  right_side_block_value == false:
					return false
				else:
					return true
		"Pressure Plate":
			var below_pos = Vector2i(pos.x,pos.y + 1)
			if current_tilemap.get_cell_tile_data(0,below_pos) != null:
				var below_tile_can_attach= current_tilemap.get_cell_tile_data(0,below_pos).get_custom_data("can_attach")
				if below_tile_can_attach:
					return true
				else:
					return false
			else:
				return false
