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
	#build_menu = null

func draw_me_mechanic(string):
	var pos = current_tilemap.tile_pos
	var global_pos = current_tilemap.map_to_local(pos)
	current_level.attach_mechanic(string,global_pos)
	current_tilemap.release()
	#build_menu = null

func cancel_build():
	current_tilemap.release()
	#build_menu = null

func reset_build_menu():
	current_tilemap.reset_everything()
	build_menu.remove_me()
	current_tilemap.release()
	#build_menu = null
