extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 200
export var FRICTION = 500

const KurapikaChainBullet = preload("res://GameScene/KurapikaChainBullet.tscn")

enum{
	MOVE_UP,
	MOVE_DOWN,
	MOVE_RIGHT,
	MOVE_LEFT,
	ATTACK,
	DEAD,
	STILL
}

onready var state = STILL
onready var velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		MOVE_UP:
			move_up(delta)
		MOVE_DOWN:
			move_down(delta)
		MOVE_RIGHT:
			move_right(delta)
		MOVE_LEFT:
			move_left(delta)
		ATTACK:
			pass
		DEAD:
			pass
		STILL:
			# State at the beginning of the game, kurapika does nothing.
			if get_vector_movement() != Vector2.ZERO:
				decide_kurapikas_movement()
	
	if Input.is_action_just_pressed("attack") and state != STILL:
		attack()

# Depending on the vector movement, Kurapika's state is set
func decide_kurapikas_movement():
	var input_vector = get_vector_movement()
	
	if input_vector.x > 0:
		state = MOVE_RIGHT
	if input_vector.x < 0:
		state = MOVE_LEFT
	if input_vector.y > 0:
		state = MOVE_DOWN
	if input_vector.y < 0:
		state = MOVE_UP

# Detects the vector movement and returns it.
func get_vector_movement():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector

# Moves Kurapika up
func move_up(delta):
	velocity = velocity.move_toward(Vector2(0,-1) * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	decide_kurapikas_movement()

# Moves Kurapika down
func move_down(delta):
	velocity = velocity.move_toward(Vector2(0,1) * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	decide_kurapikas_movement()

# Moves Kurapika right
func move_right(delta):
	velocity = velocity.move_toward(Vector2(1,0) * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	decide_kurapikas_movement()

# Moves Kurapika left
func move_left(delta):
	velocity = velocity.move_toward(Vector2(-1,0) * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	decide_kurapikas_movement()

# Function to detect when Kurapika gets hit eiter by a spider bullet or by
# having contact with an enemy. The Game Ends.
func _on_Hurtbox_area_entered(area):
	pass # Replace with function body.

# When user presses space, Kurapika attacks by shooting a dagger in the same
# direcion Kurapika is moving
func attack():
	var bullet = KurapikaChainBullet.instance()
	bullet.init(state,global_position)
	self.get_parent().add_child(bullet)








