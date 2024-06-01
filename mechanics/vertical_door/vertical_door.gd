extends Mechanics

var opened = false

func change():
	
	if self.opened == false:
		$anim.play("open")
		self.opened = true
	elif self.opened:
		$anim.play_backwards("open")
		self.opened = false

func _ready():
	gravity_scale = 0
	basic_setup()

func _process(delta):
	if self.power:
		self.power = false
		change()
		
