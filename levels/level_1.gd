extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.canvas_layer = $CanvasLayer
	$TileMap.mouse = $Mouse
	print("level 1")
	

