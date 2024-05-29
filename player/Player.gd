extends CharacterBody2D

var current_hammer = null
var grabbed = false

@onready var hammer = $Marker2D/Hand/Marker2D/hammer

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hand_rotation = Vector2()

func _ready():
	Global.player = self

func _process(delta):
	current_hammer = $Marker2D/Hand/Marker2D/hammer.current


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and grabbed == false:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if grabbed == false:
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = -SPEED
	
	if hammer.flip_v:
		if global_position.y <=  $Marker2D/Hand/Marker2D/hammer/long_head_2.global_position.y and grabbed:
			velocity.y = JUMP_VELOCITY
			grabbed = false
			hammer.offset.y = hammer.offsets[hammer.current]
	else:
		if global_position.y <=  $Marker2D/Hand/Marker2D/hammer/long_head_1.global_position.y and grabbed:
			velocity.y = JUMP_VELOCITY
			grabbed = false
			hammer.offset.y = hammer.offsets[hammer.current]
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction and !grabbed:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
			$Marker2D/Hand/Marker2D/hammer.flip_v = true
			correct_pos(current_hammer)

		else:
			$AnimatedSprite2D.flip_h = false
			$Marker2D/Hand/Marker2D/hammer.flip_v = false
			correct_pos(current_hammer)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	if grabbed == false:
		$Marker2D.look_at(get_global_mouse_position())
	else:
		if $Marker2D/Hand/Marker2D/hammer.flip_v == false:
			hammer.global_rotation = 0
		else:
			hammer.global_rotation = 3
	
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
