extends Area2D
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$LPCAnimatedSprite2D/idle.play()
		$LPCAnimatedSprite2D/idle2.play()
	if velocity.x < 0:
		$LPCAnimatedSprite2D/idle.animation = "WALK_LEFT"
		$LPCAnimatedSprite2D/idle2.animation = "WALK_LEFT"
	if velocity.x > 0:
		$LPCAnimatedSprite2D/idle.animation = "WALK_RIGHT"
		$LPCAnimatedSprite2D/idle2.animation = "WALK_RIGHT"
	if velocity.y < 0:
		$LPCAnimatedSprite2D/idle.animation = "WALK_UP"
		$LPCAnimatedSprite2D/idle2.animation = "WALK_UP"
	if velocity.y > 0:
		$LPCAnimatedSprite2D/idle.animation = "WALK_DOWN"
		$LPCAnimatedSprite2D/idle2.animation = "WALK_DOWN"
	else:
		$LPCAnimatedSprite2D/idle.stop()
		$LPCAnimatedSprite2D/idle2.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
