extends Mechanics

@export var connected_to: Mechanics
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	destructable = false
	buildable = false
	mechanic_type = "Lever"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $range.overlaps_body(player):
		$Label.show()
		if Input.is_action_just_pressed("activate_lever") and connected_to.power == false:
			connected_to.power = true
	else:
		$Label.show()
