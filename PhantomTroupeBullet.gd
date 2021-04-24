extends KinematicBody2D

const ROTATE_RIGHT = 90
const ROTATE_LEFT = -90
const ROTATE_DOWN = 180
const INITIAL_OFFSET = 70
const HitEffectScene = preload("res://Effects/HitEffect.tscn")

export var ACCELERATION = 1000
export var MAX_SPEED = 200
export var FRICTION = 500

var direction
onready var velocity = Vector2.ZERO

enum{
	MOVE_UP,
	MOVE_DOWN,
	MOVE_RIGHT,
	MOVE_LEFT
}

func _ready():
	var direction = 0

# Substitue for a constructor, this getls called when a phantom troupe member
# shoots a bullet at the moment of the instance.
func init(state, member_position):
	direction = state
	global_position = member_position
	if direction == MOVE_UP:
		global_position = global_position + Vector2(0,-INITIAL_OFFSET)
	if direction == MOVE_DOWN:
		global_position = global_position + Vector2(0,INITIAL_OFFSET)
	if direction == MOVE_RIGHT:
		global_position = global_position + Vector2(INITIAL_OFFSET,0)
	if direction == MOVE_LEFT:
		global_position = global_position + Vector2(-INITIAL_OFFSET,0)


func _physics_process(delta):
	if direction == MOVE_UP:
		velocity = velocity.move_toward(Vector2(0,-1) * MAX_SPEED, ACCELERATION * delta)
	if direction == MOVE_DOWN:
		velocity = velocity.move_toward(Vector2(0,1) * MAX_SPEED, ACCELERATION * delta)
		rotate_bullet(ROTATE_DOWN)
	if direction == MOVE_RIGHT:
		velocity = velocity.move_toward(Vector2(1,0) * MAX_SPEED, ACCELERATION * delta)
		rotate_bullet(ROTATE_RIGHT)
	if direction == MOVE_LEFT:
		velocity = velocity.move_toward(Vector2(-1,0) * MAX_SPEED, ACCELERATION * delta)
		rotate_bullet(ROTATE_LEFT)
	velocity = move_and_slide(velocity)


# Rotates the bullet alongside its collision shapes
func rotate_bullet(amount):
	self.rotation_degrees = amount

# Function called when member's bullet collides with anything
func _on_Hitbox_area_entered(area):
	var hitEffect = HitEffectScene.instance()
	hitEffect.global_position = global_position
	self.get_parent().add_child(hitEffect)
	queue_free()


func _on_Hurtbox_area_entered(area):
	var hitEffect = HitEffectScene.instance()
	hitEffect.global_position = global_position
	self.get_parent().add_child(hitEffect)
	queue_free()
