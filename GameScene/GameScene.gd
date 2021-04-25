extends Node

const CHAR_APPEARANCE_WAIT_TIME = 3
const FIRST_CHANGE_BARRIER = 15
const SECOND_CHANGE_BARRIER = 35
const THIRD_CHANGE_BARRIER = 80
const FOURTH_CHANGE_BARRIER = 150

const PHANTOM_TROUPE_MEMBER_SCENE = preload("res://GameScene/characters_scenes/PhantomTroupeMember.tscn")
const NORMAL_ENEMY_SCENE = preload("res://GameScene/characters_scenes/NormalEnemy.tscn")

# pT= phantom troupe 
onready var pT_member_chance_to_appear = 0.3
onready var enemy_chance_to_appear = 0.2
onready var friend_chance_to_appear = 0.2

onready var timer = $Timer
onready var elapsed_time = 0
onready var elapsed_seconds = 0
onready var first_phantom_troupe_member = false
onready var random = RandomNumberGenerator.new()

func _ready():
	timer.set_wait_time(CHAR_APPEARANCE_WAIT_TIME)
	timer.start()

func _process(delta):
	calculate_elapsed_time(delta)
	# Depending on the amount of elapsed_seconds, the var for chances for 
	# characters will change.
	# That's why there are barriers, when a barrier is passed the vars for chances
	# are modified.
	
	if elapsed_seconds >= FIRST_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1 
		enemy_chance_to_appear += 0.1
		friend_chance_to_appear += 0.1
	
	if elapsed_seconds >= SECOND_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1 
		enemy_chance_to_appear += 0.1
		friend_chance_to_appear += 0.1
	
	if elapsed_seconds >= THIRD_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1 
		enemy_chance_to_appear += 0.1
		friend_chance_to_appear += 0.1
	
	if elapsed_seconds >= FOURTH_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1 
		enemy_chance_to_appear += 0.1

# Calculates the amount of seconds that have passed since the GameScene started
func calculate_elapsed_time(delta):
	elapsed_time += delta
	elapsed_seconds = fmod(elapsed_time,60)
	

# Creates a phantom troupe member
func make_a_phantom_troupe_member_appear():
	var phantom_troupe_member = PHANTOM_TROUPE_MEMBER_SCENE.instance()
	add_child(phantom_troupe_member)

# Creates a normal enemy
func make_a_normal_enemy_appear():
	var normal_enemy = NORMAL_ENEMY_SCENE.instance()
	add_child(normal_enemy)

# When the timer times out
func _on_Timer_timeout():
	random.randomize()
	var random_number = random.randf_range(0,1)
	
	#print("Elapsed seconds")
	#print(elapsed_seconds)
	#print("Deciding")
	# Deciding who has to appear in the game
	if random_number <= pT_member_chance_to_appear:
		make_a_phantom_troupe_member_appear()
	if random_number <= enemy_chance_to_appear:
		make_a_normal_enemy_appear()
	if random_number <= friend_chance_to_appear:
		#print("make a friend appear")
		pass
	
	timer.set_wait_time(CHAR_APPEARANCE_WAIT_TIME)
	timer.start()






