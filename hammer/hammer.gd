extends Sprite2D

var current = 1 #0=long 1=normal 2=big
var textures = ["res://sprites/long_hammer.png","res://sprites/small_hammer.png","res://sprites/big_hammer.png"]
var offsets = [-16,-5,-12]

var fixed_pos = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change_hammer") and Global.player.grabbed == false:
		current+=1
		if current > 2:
			current = 0
		change_hammer(current)
	if Global.player.grabbed == true:
		global_position = fixed_pos
	else:
		global_position = get_parent().get_parent().global_position
	
	if flip_v:
		offset.y =  offsets[current] *-1
	else:
		offset.y = offsets[current]
	#print(global_rotation)
func set_fixed_pos():
	fixed_pos = get_parent().get_parent().global_position
		
func change_hammer(new):
	texture = load(textures[new])
	offset.y = offsets[new]
	Global.player.correct_pos(new)
	if Global.build_menu != null:
		Global.reset_build_menu()
	else:
		Global.current_tilemap.reset_everything()
