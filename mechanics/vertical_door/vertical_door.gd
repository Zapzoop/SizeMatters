extends Mechanics

var opened = false

func change():
	
	if self.opened == false:
		$anim.play("open")
		self.opened = true
	elif self.opened:
		$anim.play("close")
		self.opened = false
		

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.power:
		self.power = false
		change()
		
