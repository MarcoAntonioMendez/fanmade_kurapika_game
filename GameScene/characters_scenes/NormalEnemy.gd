extends KinematicBody2D

const MERUEM_ID = 1
const ZENO_ID = 2
const SILVA_ID = 3
const YUPI_ID = 4
const POUF_ID = 5
const NEFERPITOU_ID = 6
const HISOKA_ID = 7
const ILLUMI_ID = 8
const TOMPA_ID = 9

const X_POS_MIN = 40
const X_POS_MAX = 488
const Y_POS_MIN = 72
const Y_POS_MAX = 936
const SHOOTING_WAIT_TIME = 1.5
const TOTAL_LIVE_TIME = 6

const DEATH_EFFECT_SCENE = preload("res://Effects/DeathEffect.tscn")
const PHANTOM_TROUPE_BULLET = preload("res://GameScene/PhantomTroupeBullet.tscn")

onready var enemy_id = 0
onready var random = RandomNumberGenerator.new()
onready var sprite = $Sprite
onready var initialSpawnTimer = $InitialSpawnTimer
onready var liveTimeTimer = $LiveTimeTimer
onready var body_hurtbox = $Hurtbox/CollisionShape2D

func _ready():
	body_hurtbox.disabled = true
	random.randomize()
	enemy_id = random.randi_range(MERUEM_ID,TOMPA_ID)
	match enemy_id:
		MERUEM_ID:
			sprite.texture = load("res://GameScene/characters_scenes/meruem_head.png")
		ZENO_ID:
			sprite.texture = load("res://GameScene/characters_scenes/zeno_head.png")
		SILVA_ID:
			sprite.texture = load("res://GameScene/characters_scenes/silva_head.png")
		YUPI_ID:
			sprite.texture = load("res://GameScene/characters_scenes/yupi_head.png")
		POUF_ID:
			sprite.texture = load("res://GameScene/characters_scenes/pouf_head.png")
		NEFERPITOU_ID:
			sprite.texture = load("res://GameScene/characters_scenes/neferpitou_head.png")
		HISOKA_ID:
			sprite.texture = load("res://GameScene/characters_scenes/hisoka_head.png")
		ILLUMI_ID:
			sprite.texture = load("res://GameScene/characters_scenes/illumi_head.png")
		TOMPA_ID:
			sprite.texture = load("res://GameScene/characters_scenes/tonpa_head.png")
		
	random.randomize()
	position = Vector2(random.randi_range(X_POS_MIN,X_POS_MAX),random.randi_range(Y_POS_MIN,Y_POS_MAX))
	initialSpawnTimer.set_wait_time(SHOOTING_WAIT_TIME)
	initialSpawnTimer.start()
	liveTimeTimer.set_wait_time(TOTAL_LIVE_TIME)
	liveTimeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# If Kurapika touches a normal enemy or if Kurapika hits a normal enemy with his
# chain bullet, the game ends
func _on_Hurtbox_area_entered(area):
	var deathEffect = DEATH_EFFECT_SCENE.instance()
	deathEffect.global_position = position
	self.get_parent().add_child(deathEffect)
	queue_free()


func _on_InitialSpawnTimer_timeout():
	body_hurtbox.disabled = false


func _on_LiveTimeTimer_timeout():
	var deathEffect = DEATH_EFFECT_SCENE.instance()
	deathEffect.global_position = position
	self.get_parent().add_child(deathEffect)
	queue_free()
