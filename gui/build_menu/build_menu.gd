extends Control

func _ready():
	$AnimationPlayer.play("open")
	Global.build_menu = self

func _on_obj_1_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("coin")
			


func _on_obj_2_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("exclamation_box")


func _on_obj_3_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("cloud")


func _on_obj_4_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("flower")


func _on_obj_5_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("chain")


func _on_obj_6_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("heart")


func _on_obj_7_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Global.draw_me("crate")

func remove_me():
	self.queue_free()

func _input(event):
	if Input.is_action_pressed("escape"):
		_on_cancel_pressed()


func _on_cancel_pressed():
	Global.cancel_build()
	self.queue_free()
