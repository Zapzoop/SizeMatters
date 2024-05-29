extends Node2D

var fan = preload("res://mechanics/fan/fan.tscn")

func _ready():
	Global.current_level = self
	$TileMap.canvas_layer = $CanvasLayer
	$TileMap.mouse = $Mouse
	$TileMap.player = $Player
	print("level 1")
	

func attach_mechanic(string,global_pos):
	match string:
		"fan":
			var ins = fan.instantiate()
			ins.global_position = global_pos
			self.add_child(ins)
			
