extends Node

const CHAR_APPEARANCE_WAIT_TIME = 3
const FIRST_CHANGE_BARRIER = 15
const SECOND_CHANGE_BARRIER = 35
const THIRD_CHANGE_BARRIER = 80
const FOURTH_CHANGE_BARRIER = 150
const TIME_GAME_OVER_TAG_SHOULD_BE_PRESENT = 4

const PHANTOM_TROUPE_MEMBER_SCENE = preload("res://GameScene/characters_scenes/PhantomTroupeMember.tscn")

# pT= phantom troupe 
onready var pT_member_chance_to_appear = 0.5

onready var timer = $Timer
onready var gameOverTimer = $GameOverTimer
onready var elapsed_time = 0
onready var elapsed_seconds = 0
onready var first_phantom_troupe_member = false
onready var random = RandomNumberGenerator.new()
onready var pause_node = $CanvasLayer/Pause
onready var score = 0
onready var scoreLabel = $ScoreLabel
onready var gameOverLabel = $GameOverLabel

func _ready():
	scoreLabel.text = str(score)
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
	if elapsed_seconds >= SECOND_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1
	if elapsed_seconds >= THIRD_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1
	if elapsed_seconds >= FOURTH_CHANGE_BARRIER:
		pT_member_chance_to_appear += 0.1

# Calculates the amount of seconds that have passed since the GameScene started
func calculate_elapsed_time(delta):
	elapsed_time += delta
	elapsed_seconds = fmod(elapsed_time,60)

# Creates a phantom troupe member
func make_a_phantom_troupe_member_appear():
	var phantom_troupe_member = PHANTOM_TROUPE_MEMBER_SCENE.instance()
	add_child(phantom_troupe_member)

# When the timer times out
func _on_Timer_timeout():
	random.randomize()
	var random_number = random.randf_range(0,1)
	
	# Deciding if a phantom troupe member has to appear
	if random_number <= pT_member_chance_to_appear:
		make_a_phantom_troupe_member_appear()
	
	timer.set_wait_time(CHAR_APPEARANCE_WAIT_TIME)
	timer.start()


# Called to update the score
func update_score():
	score = score + 1
	scoreLabel.text = str(score)


# When the restart button is pressed, the game restarts.
func _on_RestartButton_pressed():
	pause_node.pause_unpause_game()
	get_tree().reload_current_scene()

# When the ExitButton is pressed, the game goes to the MenuScene
func _on_ExitButton_pressed():
	pause_node.pause_unpause_game()
	get_tree().change_scene("res://MenuScreen/MenuScene.tscn")

# Pauses the game
func _on_PauseButton_pressed():
	pause_node.pause_unpause_game()

# Reads the content of the score file and returns it
func read_score_file():
	var file = File.new()
	file.open("res://GameScene/user_score_file.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return str(content)

# Updates the content of the score file
func update_score_file(new_score):
	var file = File.new()
	file.open("res://GameScene/user_score_file.dat", File.WRITE)
	file.store_string(new_score)
	file.close()

# Reads the content of the max_score_updated file and returns it
func read_max_score_updater_file():
	var file = File.new()
	file.open("res://GameScene/was_max_score_updated.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return str(content)

# Updates the content of the max_score_updated file
func update_max_score_updated_file(value):
	var file = File.new()
	file.open("res://GameScene/was_max_score_updated.dat", File.WRITE)
	file.store_string(value)
	file.close()

# Updates the content of the last_score file
func update_last_score_file(value):
	var file = File.new()
	file.open("res://GameScene/last_score.dat", File.WRITE)
	file.store_string(value)
	file.close()

# This function is called when Kurapika dies
func activate_lost_state():
	# Reading current best score
	var old_score = int(read_score_file())
	
	# Writing score gotten
	update_last_score_file(str(score))
	
	# Updating score file
	if score > old_score:
		update_score_file(str(score))
		print("New Best Score")
		update_max_score_updated_file("true")
	else:
		print("No New Best Score")
		update_max_score_updated_file("false")
	gameOverLabel.visible = true
	
	# Starting gameOverTimer
	gameOverTimer.set_wait_time(TIME_GAME_OVER_TAG_SHOULD_BE_PRESENT)
	gameOverTimer.start()

# When GameOverTimer times out, next scene is loaded, GameOverScene
func _on_GameOverTimer_timeout():
	get_tree().change_scene("res://GameOverScene/GameOverScene.tscn")
