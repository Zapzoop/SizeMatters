extends RigidBody2D
class_name Mechanics

@export var destructable:bool
@export var large_version:bool
@export var buildable:bool
@export var enable_gravity:bool = true
@export_enum("Lever","Door","Pulley","Pressure Plate","Conveyour Belt","See-Saw","Crates","Fans") var mechanic_type:String

var enable_larger_functions = false

func set_destructable(value)->void:
	destructable = value

func get_destructable()->bool:
	return destructable

func set_collision_()->void: # sets collision for all mechanics
	set_collision_layer_value(1,true)
	set_collision_layer_value(5,true)
	set_collision_mask_value(1,true)
	set_collision_mask_value(5,true)

func basic_setup()->void: #Always run this basic setup first in _ready func of derived class
	if large_version: #Tells function that this mechanics is larger than its small one
		enable_larger_functions = true
	if enable_gravity == false:
		self.gravity_scale = 0
	set_collision_()
	if mechanic_type == null:
		return

