extends AnimatedSprite2D

var moving_right = true 
var triggered = false
var speed = 100
var left
var right



@onready var player = $/root.get_child(1).get_child(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.left = $left.global_position.x
	self.right = $right.global_position.x
	$left.hide()
	$right.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving_right:
		flip_h = true
		if self.global_position.x>=self.right:
			speed = speed * -1
			moving_right = false
			
	if !moving_right:
		flip_h = false
		if self.global_position.x<=self.left:
			speed = speed * -1
			moving_right = true
	
	
	if int(self.global_position.x) in range(player.global_position.x-10,player.global_position.x+10):
		if int(self.global_position.y) in range(player.global_position.y-150,player.global_position.x+150):
			self.triggered = true
			play("out")
		
	else:
		self.triggered = false
		
		
	if triggered == false:
		position.x += speed * delta
		play("underground")


func _on_hit_ranger_area_entered(area):
	if area.name == "big_hitbox" and self.triggered:
		if area.get_parent().current == 2:
			$despawn_timer.start()
			play("hurt")
		#inser here the death animation


func _on_despawn_timer_timeout():
	self.queue_free()
