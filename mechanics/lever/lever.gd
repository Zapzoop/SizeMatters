extends Mechanics

@export var connected_to:Array[Mechanics]
@export var player: CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.play("default")
	destructable = false
	buildable = false
	power = false
	mechanic_type = "Lever"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $range.overlaps_body(player):
		$Label.show()
		if Input.is_action_just_pressed("activate_lever") and power == false:
			power = true
			$Sprite2D.play("start")
			$Sprite2D.play("powered")
			for i in connected_to:
				print(i)
				if i.power == false:
					i.power = true
				elif i.power == true:
					i.power = false
		elif Input.is_action_just_pressed("activate_lever") and power == true:
			power = false
			$Sprite2D.play_backwards("start")
			$Sprite2D.play("default")
			for i in connected_to:
				print(i)
				if i.power == false:
					i.power = true
				elif i.power == true:
					i.power = false
	else:
		$Label.show()
