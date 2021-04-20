extends AnimatedSprite

func _ready():
	# Creating the signal by code
	# 1st param: When the animation finished.
	# 2nd param: this signal is being connected to THIS object (thus the self)
	# 3rd param: the function to be called when the signal emits
	self.connect("animation_finished",self,"on_animation_finished")
	frame = 0
	play("Animate")

func on_animation_finished():
	queue_free()
