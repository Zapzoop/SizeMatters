extends Mechanics

@export_enum("left","right") var direction: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for body: RigidBody2D in $area.get_overlapping_bodies():
		if direction == "right":
			body.apply_force(Vector2(1100,0))
		if direction == "left":
			body.apply_force(Vector2(-1100,0))
	for player: CharacterBody2D in $area.get_overlapping_bodies():
		if direction == "right":
			player.apply_force(Vector2(1100,0))
		if direction == "left":
			player.apply_force(Vector2(-1100,0))

