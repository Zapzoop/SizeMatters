extends Node2D
 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$TileMap.canvas_layer = $CanvasLayer
	$TileMap.mouse = $Mouse
	$TileMap.player = $Player
	print("level 1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
