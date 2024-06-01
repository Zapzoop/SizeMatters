extends Control

func _ready():
	print("Main menu ready")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://gui/level_selector/level_selector.tscn")
	%sfx.button()

func _on_quit_pressed():
	get_tree().quit()
	%sfx.button()
