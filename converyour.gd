extends Mechanics

@export_enum("left","right") var direction: String
@export var strenght: int = 100

var in_range = []

func _physics_process(delta):
	if power:
		for body in self.in_range:
			match direction:
				"left":
					body.linear_velocity.x = -1 * strenght/3
					print(body.linear_velocity.x)
				"right":
					body.linear_velocity.x = 1 * strenght/3
	self.linear_velocity = Vector2.ZERO

func _on_area_body_entered(body):
	if body.get_class() == "RigidBody2D":
		self.in_range.append(body)
	#print(body.get_class())

func _on_area_body_exited(body):
	if body.get_class() == "RigidBody2D":
		self.in_range.erase(body)
		body.linear_velocity = Vector2.ZERO
