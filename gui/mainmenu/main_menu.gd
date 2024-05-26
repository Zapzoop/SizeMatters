extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Main menu ready")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://gui/level_selector/level_selector.tscn")


func _on_quit_pressed():
	get_tree().quit()
