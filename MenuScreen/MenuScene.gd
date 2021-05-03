extends Node;

const MAX_START_BUTTON_FONT_SIZE = 150;
const MIN_START_BUTTON_FONT_SIZE = 110;
const GROWING = 1;
const SHRINKING = 2;

onready var menuScreenBackgroundMusic = $AudioStreamPlayer
onready var fadeInAnimation = $AnimationPlayer
onready var backgroundVideo = $VideoPlayer
onready var maxScoreLabel = $MaxScoreLabel

var currentStartButtonFontSize;
var startButtonState;

func _ready():
	#Reading user's max score
	var score = read_score_file()
	maxScoreLabel.text = maxScoreLabel.text + " " + str(score)
	
	currentStartButtonFontSize = MIN_START_BUTTON_FONT_SIZE;
	startButtonState = GROWING;
	fadeInAnimation.play("FadeIn")

func makeStartButtonGrowOrShrink():
	#Changing StartButton state
	if currentStartButtonFontSize == MIN_START_BUTTON_FONT_SIZE:
		startButtonState = GROWING
	if currentStartButtonFontSize == MAX_START_BUTTON_FONT_SIZE:
		startButtonState = SHRINKING
	#Changing StartButton size
	match startButtonState:
		GROWING:
			currentStartButtonFontSize = currentStartButtonFontSize + 1;
		SHRINKING:
			currentStartButtonFontSize = currentStartButtonFontSize - 1;
	get_node("StartButton").get("custom_fonts/font").set_size(currentStartButtonFontSize)

func deleteFadeInColorRect():
	get_node("ColorRect").queue_free()

func _process(delta):
	makeStartButtonGrowOrShrink()
	
	if menuScreenBackgroundMusic.playing == false:
		menuScreenBackgroundMusic.play()
	
	if backgroundVideo.is_playing() == false:
		backgroundVideo.play()

# Reads the content of the score file and returns it
func read_score_file():
	var file = File.new()
	file.open("res://GameScene/user_score_file.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return str(content)
