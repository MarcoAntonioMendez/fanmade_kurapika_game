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

const DEATH_EFFECT_SCENE = preload("res://Effects/DeathEffect.tscn")

onready var phantom_troupe_member_id = 0
onready var random = RandomNumberGenerator.new()
onready var sprite = $Sprite

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	var deathEffect = DEATH_EFFECT_SCENE.instance()
	deathEffect.global_position = position
	self.get_parent().add_child(deathEffect)
	queue_free()
