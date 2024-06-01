extends Mechanics


@export var fan_range:int = 3

@onready var left_area = $range_left
@onready var right_area = $range_right

var tilemap
var direction

var self_pos
var self_pos_in_map
var left_one
var right_one

var in_range = []

func _ready():
	basic_setup()
	tilemap = Global.current_tilemap
	check()

func check():
	self_pos = self.get_global_position()
	self_pos_in_map = tilemap.local_to_map(self_pos)
	left_one = Vector2i(self_pos_in_map.x - 1,self_pos_in_map.y)
	right_one = Vector2(self_pos_in_map.x + 1,self_pos_in_map.y)
	if tilemap.get_cell_tile_data(0,left_one) != null and tilemap.get_cell_tile_data(0,right_one) == null:
		var left_side_block_value = tilemap.get_cell_tile_data(0,left_one).get_custom_data("can_attach")
		if left_side_block_value == true:
			direction = "right"
			left_area.process_mode = Node.PROCESS_MODE_DISABLED
			left_area.hide()
	elif tilemap.get_cell_tile_data(0,left_one) == null and tilemap.get_cell_tile_data(0,right_one) != null:
		var right_side_block_value = tilemap.get_cell_tile_data(0,right_one).get_custom_data("can_attach")
		if right_side_block_value == true:
			direction = "left"
			right_area.process_mode = Node.PROCESS_MODE_DISABLED
			right_area.hide()
	elif tilemap.get_cell_tile_data(0,left_one) != null and tilemap.get_cell_tile_data(0,right_one) != null:
		var left_side_block_value = tilemap.get_cell_tile_data(0,left_one).get_custom_data("can_attach")
		var right_side_block_value = tilemap.get_cell_tile_data(0,right_one).get_custom_data("can_attach")
		if left_side_block_value == true and  right_side_block_value == false:
			direction = "right"
			left_area.process_mode = Node.PROCESS_MODE_DISABLED
			left_area.hide()
		elif left_side_block_value == false and  right_side_block_value == true:
			direction = "left"
			right_area.process_mode = Node.PROCESS_MODE_DISABLED
			right_area.hide()
		elif left_side_block_value == true and  right_side_block_value == true:
			direction = "left"
			right_area.process_mode = Node.PROCESS_MODE_DISABLED
			right_area.hide()

func _input(event):
	if Input.is_action_pressed("click") and Global.player.current_hammer == 2:
		if tilemap.tile_pos ==  tilemap.local_to_map(get_global_position()):
			self.queue_free()
			Global.build_menu.add_mechanic("Fan")

func _physics_process(delta):
	if power:
		print(direction)
		$Sprite2D.play("start")
		for i in in_range:
			if direction == "left":
				i.apply_force(Vector2(-1100,0))
			else:
				i.apply_force(Vector2(1100,0))
	elif !power:
		$Sprite2D.play("default")

func _on_range_left_body_entered(body):
	if body.is_in_group("light"):
		in_range.append(body)
		#print("left append")


func _on_range_right_body_entered(body):
	if body.is_in_group("light"):
		in_range.append(body)
		#print("right append")

func _on_range_left_body_exited(body):
	if body.is_in_group("light"):
		body.linear_velocity = Vector2.ZERO
		#body.constant_force = Vector2(0, 0)
		in_range.erase(body)

func _on_range_right_body_exited(body):
	if body.is_in_group("light"):
		body.linear_velocity = Vector2.ZERO
		#body.constant_force = Vector2(0, 0)
		in_range.erase(body)
