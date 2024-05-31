extends Mechanics

@export_enum("left","right") var direction: String
@export_enum("100","200","300") var strenght: int

var in_range = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if power:
		for body in self.in_range:
			body.linear_velocity.x = -30
			
	self.linear_velocity = Vector2.ZERO

func _on_area_body_entered(body):
	if body.get_class() == "RigidBody2D":
		self.in_range.append(body)
	print(body.get_class())


func _on_area_body_exited(body):
	if body.get_class() == "RigidBody2D":
		self.in_range.erase(body)
		body.linear_velocity = Vector2.ZERO
