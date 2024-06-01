extends Node2D

var scene_path = {
	"Pressure Plate":"res://mechanics/pressure_plate/pressure_plate.tscn",
	"Fan":"res://mechanics/fan/fan.tscn",
	"Wooden Crate":"res://mechanics/crates/wooden/wooden_crate.tscn"
}

func _ready():
	Global.current_level = self
	$TileMap.canvas_layer = $CanvasLayer
	$TileMap.mouse = $Mouse
	$TileMap.player = $Player
	print("level 1")
	

func attach_mechanic(string,global_pos):
	match string:
		"Fan":
			var to_load = load(scene_path["Fan"])
			var ins = to_load.instantiate()
			ins.global_position = global_pos
			self.add_child(ins)
		"Pressure Plate":
			var to_load = load(scene_path["Pressure Plate"])
			var ins = to_load.instantiate()
			ins.global_position = global_pos
			self.add_child(ins)
		"Wooden Crate":
			var to_load = load(scene_path["Wooden Crate"])
			var ins = to_load.instantiate()
			ins.global_position = global_pos
			self.add_child(ins)


func _on_end_body_entered(body):
	pass # Replace with function body.
