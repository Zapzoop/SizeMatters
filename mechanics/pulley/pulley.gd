extends Mechanics

var rope_left_img = preload("res://temp_art/rope_left.png")
var rope_right_img = preload("res://temp_art/rope_right.png")

@export var rope_left_length:int
@export var rope_right_length:int

@onready var left_area = $left_place
@onready var right_area = $right_place

func _ready():
	basic_setup()
	setup_rope()
	setup_area()

func pos_setter(num,dir):
	var vector = Vector2.ZERO;
	if dir == "left":
		vector.x = -4
	elif dir == "right":
		vector.x = 4
	else:
		print("Wrong Direction given to rope pos")
	vector.y = 16+(num*16)
	return vector

func setup_rope():
	for i in range(rope_left_length):
		var sprite = Sprite2D.new()
		sprite.texture = rope_left_img
		var pos = pos_setter(i,"left")
		sprite.position = pos
		self.add_child(sprite)
	for i in range(rope_right_length):
		var sprite = Sprite2D.new()
		sprite.texture = rope_right_img
		var pos = pos_setter(i,"right")
		sprite.position = pos
		self.add_child(sprite)

func set_area(dir):
	var pos = Vector2.ZERO
	if dir == "left":
		pos.y = 16+(rope_left_length * 16)
		pos.x = -8
	elif dir == "right":
		pos.y = 16+(rope_right_length * 16)
		pos.x = 8
	else:
		print("Wrong Direction given to area pos")
	return pos
	
func setup_area():
	var position_to_left = set_area("left")
	var position_to_right = set_area("right")
	
	left_area.position = position_to_left
	right_area.position = position_to_right
