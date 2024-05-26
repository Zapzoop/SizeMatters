extends AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()

	if Input.is_action_pressed("click"):
		$".".play("click")
	else:
		$".".play("default")
