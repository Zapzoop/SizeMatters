extends TileMap

#These three are set by current level
var canvas_layer
var mouse
var player

var indicator = preload("res://gui/tile_selector/tile_selector.tscn")
var build_menu = preload("res://gui/build_menu/build_menu.tscn")

#To tell the tilemap where to draw the indicator
var mouse_pos:Vector2
var tile_pos:Vector2i
var previous_tile_pos:Vector2i

#When build menu is activated we want to lock the position of indicator
var locked_tile_pos:Vector2i
var is_locked = false

#Variables for performing different actions like can player build there, destroy the block or grab the block
var can_build = false
var can_destroy_current_block = false
var can_grab_current_block = false

#Range variables for checking if the action is in range (Range is from negative to positive)
var range_for_build = Vector2i(3,3) #inclusive
var range_for_movement = Vector2i(1,4)
var reach = false

func _ready():
	Global.current_tilemap = self #Sets the current_tilemap in Global as self
	pass

func is_inside_range(pos,range): # Outputs if the current position of tile is inside range or not
	var player_pos = local_to_map(player.global_position)
	if (pos.x <= player_pos.x + range.x and pos.x >= player_pos.x - range.x) and (pos.y <= player_pos.y + range.y and pos.y >= player_pos.y - range.y):
		return true
	else:
		return false

func _process(delta):
	#If buildmenu is not activated we can draw indicator
	if !is_locked:
		tile_pos = local_to_map(get_global_mouse_position()) #Converts the global_mouse position to position on tilemap in (x,y) i.e convert 16 in x and 16 in y at (1,1)
		if is_inside_range(tile_pos,range_for_build): #If the current mouse_pos is inside range then
			reach = true #Makes the reach variable true
			if player.current_hammer == 1: #If current hammer is build hammer then
				if tile_pos != previous_tile_pos or previous_tile_pos == null: #Check if new position is not old position as this will run every frame so draw only on new pos
					#If the tile is empty then erase the previous indicator and draw new one and set build to true 
					if get_cell_tile_data(0,tile_pos) == null: 
						erase_cell(1,previous_tile_pos) 
						set_cell(1,tile_pos,2,Vector2i(0,0),1) 
						can_build = true 
					elif get_cell_tile_data(0,tile_pos) != null: 
						erase_cell(1,previous_tile_pos) 
						can_build = false 
			if player.current_hammer == 2: #If current hammer is destroy hammer
				if tile_pos != previous_tile_pos or previous_tile_pos == null:
					erase_cell(1,previous_tile_pos)
					set_cell(1,tile_pos,2,Vector2i(0,0),1)
					#If it is not empty then check if block can be destroyed or not
					if get_cell_tile_data(0,tile_pos) != null:
						can_destroy_current_block = get_cell_tile_data(0,tile_pos).get_custom_data("destructable")
					elif get_cell_tile_data(0,tile_pos) == null:
						erase_cell(1,previous_tile_pos)
						can_destroy_current_block = false
			reach = false
			#This is for checking the range of long hammer
			if is_inside_range(tile_pos,range_for_movement):
				reach = true
				#If tile is not empty checks the above tile if it is not empty the return else check if it is grabable or not 
				if player.current_hammer == 0:
					if tile_pos != previous_tile_pos or previous_tile_pos == null:
						if get_cell_tile_data(0,tile_pos) != null:
							if get_cell_tile_data(0,Vector2i(tile_pos.x,tile_pos.y-1)) != null:
								return
							erase_cell(1,previous_tile_pos)
							set_cell(1,tile_pos,2,Vector2i(0,0),1)
							can_grab_current_block = get_cell_tile_data(0,tile_pos).get_custom_data("destructable")
						elif get_cell_tile_data(0,tile_pos) == null:
							erase_cell(1,previous_tile_pos)
							can_grab_current_block = false
			#Use for clearing indicator for long_hammer when it goes out of range
			elif player.current_hammer == 0:
				erase_cell(1,previous_tile_pos)
		#When it is not inside range clear the previous block and set everything to false
		else:
			reach = false
			can_build= false
			can_destroy_current_block = false
			can_grab_current_block = false
			erase_cell(1,previous_tile_pos)
		previous_tile_pos = tile_pos

# works based on if can_build or destory or grab 
# for build opens build menu and makes mouse visible for destory destorys the block for grabable move the player to the pos
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and is_locked == false and can_build:
			is_locked = true
			locked_tile_pos = tile_pos
			Global.build_menu.opened = true
			Global.build_menu.anim.play("open")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse.hide()
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and is_locked == false and can_destroy_current_block:
			Global.build_menu.add_tile(get_cell_atlas_coords(0,tile_pos))
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

#Handles the block to draw from the build menu
func place_block(vect:Vector2i):
	var player_pos  = local_to_map(player.global_position)
	var player_up_pos = Vector2i(player_pos.x,player_pos.y-1)
	if player_pos == tile_pos or player_up_pos == tile_pos:
		release()
		return
	set_cell(0,tile_pos,0,vect,0)
	release()
#Makes the locked to false and hides the mouse
func release():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#mouse.show()
	is_locked = false

#Called when hammer is changed for a small amount of time can't build or destroy anything
func reset_everything():
	reach = false
	erase_cell(1,previous_tile_pos)
	can_build = false
	can_destroy_current_block = false
	can_grab_current_block = false
	is_locked = false

func get_data(layer,coords):
	print("Atlas_coords "+ str(get_cell_atlas_coords(layer,coords)))
	print("Alternative_tile " + str(get_cell_alternative_tile(layer,coords)))
	print("Source_id " + str(get_cell_source_id(layer,coords)))
