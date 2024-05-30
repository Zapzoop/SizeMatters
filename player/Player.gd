extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var ray_cast2: RayCast2D = $RayCast2D2

var current_hammer = null

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction

var hand_rotation = Vector2()

func _ready():
	Global.player = self
	ray_cast.rotation_degrees = -90
	ray_cast2.rotation_degrees = -90

func _process(delta):
	current_hammer = $Marker2D/Hand/Marker2D/hammer.current


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
			ray_cast.rotation_degrees = 90
			ray_cast2.rotation_degrees = 90
			$Marker2D/Hand/Marker2D/hammer.flip_v = true
			correct_pos(current_hammer)

		else:
			$AnimatedSprite2D.flip_h = false
			ray_cast.rotation_degrees = -90
			ray_cast2.rotation_degrees = -90
			$Marker2D/Hand/Marker2D/hammer.flip_v = false
			correct_pos(current_hammer)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		
	var ray_collision = ray_cast.get_collision_point()
	var ray_collision_2 = ray_cast2.get_collision_point()
	if ray_collision and ray_collision.y - global_position.y == -6 and int(ray_collision.x)-int(ray_collision_2.x) != 0:
		velocity.y = -120
		#move_and_slide()
	#print(velocity)
		
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	
	$Marker2D.look_at(get_global_mouse_position())
	
	move_and_slide()


func correct_pos(new):
	if $Marker2D/Hand/Marker2D/hammer.flip_v == true:
		match new:
			0:
				$Marker2D/Hand/Marker2D/hammer.position = Vector2(1,-36)
			1:
				$Marker2D/Hand/Marker2D/hammer.position = Vector2(-1,-6)
			2:
				$Marker2D/Hand/Marker2D/hammer.position = Vector2(0,-13)
	else:
		match new:
			0:
				$Marker2D/Hand/Marker2D/hammer.position = Vector2(1,36)
			1:
				$Marker2D/Hand/Marker2D/hammer.position = Vector2(-1,6)
			2:
				$Marker2D/Hand/Marker2D/hammer.position = Vector2(0,13)
