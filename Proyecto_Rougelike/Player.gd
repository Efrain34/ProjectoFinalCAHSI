extends CharacterBody2D 
const ACCELERATION = 800
const FRICTION = 500
const MAXSPEED = 120

enum {Walking}
var state = Walking

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/Walking/walking_2D/blend_position"
]
var animTree_state_keys = [
	"Walking"
]
func _physics_process(delta):
	move(delta)
	animate()
func move(delta):
	var input_vector = Input.get_vector("Move_LEFT", "Move_RIGHT", "Move_UP", "Move_DOWN")
	if input_vector == Vector2.ZERO:
		state = Walking
		apply_friction(FRICTION * delta)
	else:
		state = Walking
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()
func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAXSPEED)
	
func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)

