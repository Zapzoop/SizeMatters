extends Control

var paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_pressed("escape") and Global.build_menu.opened ==false and paused == false:
		self.show()
		paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true

func _on_resume_pressed():
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		paused = false
		get_tree().paused = false
		self.hide()


func _on_button_pressed():
	get_tree().quit()
