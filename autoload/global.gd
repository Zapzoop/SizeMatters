extends Node

var build_menu
var current_tilemap

var craftable_coords = {
	"coin":Vector2i(1,0),
	"exclamation_box":Vector2i(7,2),
	"cloud":Vector2i(13,0),
	"flower":Vector2i(16,0),
	"chain":Vector2i(3,1),
	"heart":Vector2i(2,2),
	"crate":Vector2i(11,2),
	}

func draw_me(string):
	current_tilemap.place_block(craftable_coords[string])
	build_menu.remove_me()
	build_menu = null

func cancel_build():
	current_tilemap.release()
	build_menu = null
