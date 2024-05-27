extends Sprite2D

var current = 1 #0=long 1=normal 2=big
var textures = ["res://sprites/long_hammer.png","res://sprites/small_hammer.png","res://sprites/big_hammer.png"]
var positions = [Vector2(0.907,36.002),Vector2(-1.015,5.997),Vector2(-0.034,13)]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change_hammer"):
		current+=1
		if current > 2:
			current = 0
		change_hammer(current)
	
func change_hammer(new):
	texture = load(textures[new])
	position = positions[new]
	Global.player.correct_pos(new)
