extends Node

const CHAR_APPEARANCE_WAIT_TIME = 3

# pT= phantom troupe 
onready var pT_member_chance_to_appear = 0.5
onready var enemy_chance_to_appear = 0.5
onready var friend_chance_to_appear = 0.5

onready var timer = $Timer

onready var random = RandomNumberGenerator.new()

func _ready():
	timer.set_wait_time(CHAR_APPEARANCE_WAIT_TIME)
	timer.start()

func _process(delta):
	pass

# When the timer times out
func _on_Timer_timeout():
	random.randomize()
	var random_number = random.randf_range(0,1)
	
	print("Deciding")
	# Deciding who has to appear in the game
	if random_number <= pT_member_chance_to_appear:
		print("make a phantom troupe member appear")
		pass
	if random_number <= enemy_chance_to_appear:
		print("make an enemy appear")
		pass
	if random_number <= friend_chance_to_appear:
		print("make a friend appear")
		pass
	
	timer.set_wait_time(CHAR_APPEARANCE_WAIT_TIME)
	timer.start()














