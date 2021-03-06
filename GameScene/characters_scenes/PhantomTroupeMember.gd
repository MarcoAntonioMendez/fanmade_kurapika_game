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
const Y_POS_MIN = 128
const Y_POS_MAX = 936
const SHOOTING_WAIT_TIME = 1.2

enum{
	DIRECTION_UP,
	DIRECTION_DOWN,
	DIRECTION_RIGHT,
	DIRECTION_LEFT
}

const DEATH_EFFECT_SCENE = preload("res://Effects/DeathEffect.tscn")
const PHANTOM_TROUPE_BULLET = preload("res://GameScene/PhantomTroupeBullet.tscn")
var chrollo_sprite = preload("res://GameScene/characters_scenes/chrollo_head.png")
var feitan_sprite = preload("res://GameScene/characters_scenes/feitan_head.png")
var uvogin_sprite = preload("res://GameScene/characters_scenes/uvogin_head.png")
var phinks_sprite = preload("res://GameScene/characters_scenes/phinks_head.png")
var shalnark_sprite = preload("res://GameScene/characters_scenes/shalnark_head.png")
var bonolenov_sprite = preload("res://GameScene/characters_scenes/bonolenov_head.png")
var nobunaga_sprite = preload("res://GameScene/characters_scenes/nobunaga_head.png")
var franklin_sprite = preload("res://GameScene/characters_scenes/franklin_head.png")
var machi_sprite = preload("res://GameScene/characters_scenes/machi_head.png")
var shizuku_sprite = preload("res://GameScene/characters_scenes/shizuku_head.png")
var pakunoda_sprite = preload("res://GameScene/characters_scenes/pakunoda_head.png")
var kalluto_sprite = preload("res://GameScene/characters_scenes/kalluto_head.png")
var kortopi_sprite = preload("res://GameScene/characters_scenes/kortopi_head.png")

onready var phantom_troupe_member_id = 0
onready var random = RandomNumberGenerator.new()
onready var sprite = $Sprite
onready var timer = $Timer
onready var body_hitbox = $Hitbox/CollisionShape2D

func _ready():
	body_hitbox.disabled = true
	random.randomize()
	phantom_troupe_member_id = random.randi_range(CHROLLO_ID,KORTOPI_ID)
	match phantom_troupe_member_id:
		CHROLLO_ID:
			sprite.texture = chrollo_sprite
		FEITAN_ID:
			sprite.texture = feitan_sprite
		UVOGIN_ID:
			sprite.texture = uvogin_sprite
		PHINKS_ID:
			sprite.texture = phinks_sprite
		SHALNARK_ID:
			sprite.texture = shalnark_sprite
		BONOLENOV_ID:
			sprite.texture = bonolenov_sprite
		NOBUNAGA_ID:
			sprite.texture = nobunaga_sprite
		FRANKLIN_ID:
			sprite.texture = franklin_sprite
		MACHI_ID:
			sprite.texture = machi_sprite
		SHIZUKU_ID:
			sprite.texture = shizuku_sprite
		PAKUNODA_ID:
			sprite.texture = pakunoda_sprite
		KALLUTO_ID:
			sprite.texture = kalluto_sprite
		KORTOPI_ID:
			sprite.texture = kortopi_sprite
	
	random.randomize()
	position = Vector2(random.randi_range(X_POS_MIN,X_POS_MAX),random.randi_range(Y_POS_MIN,Y_POS_MAX))
	timer.set_wait_time(SHOOTING_WAIT_TIME)
	timer.start()

#func _process(delta):
#	pass

# Makes a phantom troupe member shoot, it takes a list of number denoting direction
# and number of bullets
# Example:
# List received: [1,0,0,0] -> One bullet facing DIRECTION_UP, none of the others
#
# List received: [1,0,1,1] ->  1 bullet for DIRECTION_UP, 1 for DIRECTION_RIGHT, 1 for DIRECTION_LEFT
func make_phantom_troupe_member_shoot(bullets_specifications_list):
	var direction = 0
	for bullet in bullets_specifications_list:
		if bullet == 1:
			var phantomTroupeBullet = PHANTOM_TROUPE_BULLET.instance()
			phantomTroupeBullet.init(direction,global_position)
			get_parent().add_child(phantomTroupeBullet)
		direction = direction + 1

func _on_Hurtbox_area_entered(area):
	var deathEffect = DEATH_EFFECT_SCENE.instance()
	deathEffect.global_position = position
	self.get_parent().add_child(deathEffect)
	self.get_parent().update_score()
	self.get_parent().play_phantom_troupe_member_death_sfx()
	queue_free()


func _on_Timer_timeout():
	body_hitbox.disabled = false
	match phantom_troupe_member_id:
		CHROLLO_ID:
			make_phantom_troupe_member_shoot([1,1,1,1])
		FEITAN_ID:
			make_phantom_troupe_member_shoot([1,1,0,1])
		UVOGIN_ID:
			make_phantom_troupe_member_shoot([0,1,1,1])
		PHINKS_ID:
			make_phantom_troupe_member_shoot([1,0,1,1])
		SHALNARK_ID:
			make_phantom_troupe_member_shoot([1,1,1,0])
		BONOLENOV_ID:
			make_phantom_troupe_member_shoot([0,1,0,1])
		NOBUNAGA_ID:
			make_phantom_troupe_member_shoot([0,1,1,0])
		FRANKLIN_ID:
			make_phantom_troupe_member_shoot([1,0,0,1])
		MACHI_ID:
			make_phantom_troupe_member_shoot([1,1,0,0])
		SHIZUKU_ID:
			make_phantom_troupe_member_shoot([1,0,1,0])
		PAKUNODA_ID:
			make_phantom_troupe_member_shoot([0,1,0,0])
		KALLUTO_ID:
			make_phantom_troupe_member_shoot([0,0,1,0])
		KORTOPI_ID:
			make_phantom_troupe_member_shoot([1,0,0,0])
	timer.set_wait_time(SHOOTING_WAIT_TIME)
	timer.start()
