extends KinematicBody2D

const CHROLLO_ID = 1
const FEITAN_ID = 2
const UVOGIN_ID = 3
const PHINKS_ID = 4
const SHALNARK_ID = 5
const BONOLENOV_ID = 6
const NOBUNAGA_ID = 7
const FRANKLIN_ID = 8
const MACHI_ID = 9
const SHIZUKU_ID = 10
const PAKUNODA_ID = 11
const KALLUTO_ID = 12
const KORTOPI_ID = 13

const X_POS_MIN = 40
const X_POS_MAX = 488
const Y_POS_MIN = 72
const Y_POS_MAX = 936
const SHOOTING_WAIT_TIME = 1

enum{
	DIRECTION_UP,
	DIRECTION_DOWN,
	DIRECTION_RIGHT,
	DIRECTION_LEFT
}

const DEATH_EFFECT_SCENE = preload("res://Effects/DeathEffect.tscn")
const PHANTOM_TROUPE_BULLET = preload("res://GameScene/PhantomTroupeBullet.tscn")

onready var phantom_troupe_member_id = 0
onready var random = RandomNumberGenerator.new()
onready var sprite = $Sprite
onready var timer = $Timer

func _ready():
	random.randomize()
	phantom_troupe_member_id = random.randi_range(CHROLLO_ID,KORTOPI_ID)
	match phantom_troupe_member_id:
		CHROLLO_ID:
			sprite.texture = load("res://GameScene/characters_scenes/chrollo_head.png")
		FEITAN_ID:
			sprite.texture = load("res://GameScene/characters_scenes/feitan_head.png")
		UVOGIN_ID:
			sprite.texture = load("res://GameScene/characters_scenes/uvogin_head.png")
		PHINKS_ID:
			sprite.texture = load("res://GameScene/characters_scenes/phinks_head.png")
		SHALNARK_ID:
			sprite.texture = load("res://GameScene/characters_scenes/shalnark_head.png")
		BONOLENOV_ID:
			sprite.texture = load("res://GameScene/characters_scenes/bonolenov_head.png")
		NOBUNAGA_ID:
			sprite.texture = load("res://GameScene/characters_scenes/nobunaga_head.png")
		FRANKLIN_ID:
			sprite.texture = load("res://GameScene/characters_scenes/franklin_head.png")
		MACHI_ID:
			sprite.texture = load("res://GameScene/characters_scenes/machi_head.png")
		SHIZUKU_ID:
			sprite.texture = load("res://GameScene/characters_scenes/shizuku_head.png")
		PAKUNODA_ID:
			sprite.texture = load("res://GameScene/characters_scenes/pakunoda_head.png")
		KALLUTO_ID:
			sprite.texture = load("res://GameScene/characters_scenes/kalluto_head.png")
		KORTOPI_ID:
			sprite.texture = load("res://GameScene/characters_scenes/kortopi_head.png")
	
	random.randomize()
	position = Vector2(random.randi_range(X_POS_MIN,X_POS_MAX),random.randi_range(Y_POS_MIN,Y_POS_MAX))
	timer.set_wait_time(SHOOTING_WAIT_TIME)
	timer.start()

#func _process(delta):
#	pass

# Makes Kortopi shoot a spider, according to his beaheviour
func make_kortopi_shoot():
	var phantomTroupeBullet = PHANTOM_TROUPE_BULLET.instance()
	phantomTroupeBullet.init(DIRECTION_UP,global_position)
	get_parent().add_child(phantomTroupeBullet)


func _on_Hurtbox_area_entered(area):
	var deathEffect = DEATH_EFFECT_SCENE.instance()
	deathEffect.global_position = position
	self.get_parent().add_child(deathEffect)
	queue_free()


func _on_Timer_timeout():
	match phantom_troupe_member_id:
		CHROLLO_ID:
			pass
		FEITAN_ID:
			pass
		UVOGIN_ID:
			pass
		PHINKS_ID:
			pass
		SHALNARK_ID:
			pass
		BONOLENOV_ID:
			pass
		NOBUNAGA_ID:
			pass
		FRANKLIN_ID:
			pass
		MACHI_ID:
			pass
		SHIZUKU_ID:
			pass
		PAKUNODA_ID:
			pass
		KALLUTO_ID:
			pass
		KORTOPI_ID:
			make_kortopi_shoot()
	timer.set_wait_time(SHOOTING_WAIT_TIME)
	timer.start()
