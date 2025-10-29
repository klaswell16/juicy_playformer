extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0  

@onready var jump_sound = $JumpSound
func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# Get input direction
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle animation
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	$Animator.speed = abs(velocity.x)
	$Animator.on_ground = is_on_floor()

	# Move and handle collisions
	move_and_slide()
