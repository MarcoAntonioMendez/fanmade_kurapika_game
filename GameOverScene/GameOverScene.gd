extends Node

const TRUE = "true"
const FALSE = "false"

onready var score_text_label = $ScoreTextLabel
onready var score_label = $ScoreLabel
onready var was_max_score_update_file_path = "res://GameScene/was_max_score_updated.dat"
onready var last_score_gotten_path = "res://GameScene/last_score.dat"

func _ready():
	#Checking is user beat best score
	var was_max_score_updated = read_custom_file(was_max_score_update_file_path)
	if was_max_score_updated == TRUE:
		score_text_label.text = "New Best Score"
	else:
		score_text_label.text = "Your Score"
	
	# Reading actual score user got.
	var last_score = read_custom_file(last_score_gotten_path)
	score_label.text = last_score

# Reads the content of a file, its path is provided as a parameter
func read_custom_file(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	return str(content)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
