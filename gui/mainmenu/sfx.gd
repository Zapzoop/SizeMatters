extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	stream = load("res://audio/menu_opening.wav")
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func button():
	stream = load("res://audio/button.wav")
	play()

func closed():
	stream = load("res://audio/menu_closing.wav")
	play()

func _on_v_box_container_mouse_entered():
	stream = load("res://audio/selected_button.wav")
	play()
