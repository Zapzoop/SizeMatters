extends Mechanics

var can_power_others = false

var is_pressed = false

var in_range = []

var body_pressing

var tilemap

var self_pos
var self_pos_in_map
var below_pos

func _ready():
	basic_setup()
	$AnimatedSprite2D.play("not_pressed")
	tilemap = Global.current_tilemap
	check()

func check():
	self_pos = self.get_global_position()
	self_pos_in_map = tilemap.local_to_map(self_pos)
	below_pos = Vector2i(self_pos_in_map.x,self_pos_in_map.y + 1)
	if tilemap.get_cell_tile_data(0,below_pos) != null:
		var below_tile_can_attach= tilemap.get_cell_tile_data(0,below_pos).get_custom_data("can_attach")
		if below_tile_can_attach:
			pass
		else:
			self.queue_free()
			Global.reset_build_menu()
	else:
		self.queue_free()
		Global.reset_build_menu()

func _process(delta):
	if power:
		can_power_others = true
	elif power == false:
		can_power_others = false

	if can_power_others:
		for i in in_range:
			i.power = true
	elif can_power_others:
		for i in in_range:
			i.power = false

func _input(event):
	if Input.is_action_pressed("click") and Global.player.current_hammer == 2:
		if tilemap.tile_pos ==  tilemap.local_to_map(get_global_position()):
			if not in_range.is_empty():
				for i in in_range:
					i.power = false
			self.queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("mechanics"):
		if is_pressed == false:
			is_pressed = true
			power = true
			body_pressing = body
			$AnimatedSprite2D.play("pressing")
			$AnimatedSprite2D.play("pressed")

func _on_area_2d_body_exited(body):
	if body.is_in_group("mechanics"):
		if is_pressed == true and body == body_pressing:
			is_pressed = false
			power = false
			body_pressing = null
			$AnimatedSprite2D.play("un_pressing")
			$AnimatedSprite2D.play("not_pressed")

func _on_power_others_body_entered(body):
	if body.is_in_group("can_be_powered"):
		in_range.append(body)

func _on_power_others_body_exited(body):
	if body.is_in_group("can_be_powered"):
		body.power = false
		in_range.erase(body)
