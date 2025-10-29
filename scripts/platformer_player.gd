extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0  

@onready var jump_sound = $JumpSound

const WALL_JUMP_VELOCITY = Vector2(400, -450)  
const WALL_SLIDE_SPEED = 100.0  # Max fall speed when sliding
var max_wall_jumps = 1
var wall_jumps_remaining = 0
var is_wall_sliding = false
var last_wall_normal = 0

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	# Reset wall jump
	if is_on_floor():
		wall_jumps_remaining = max_wall_jumps
		is_wall_sliding = false
	
	if is_on_wall() and not is_on_floor() and velocity.y > 0:
		is_wall_sliding = true
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED)
		last_wall_normal = get_wall_normal().x
	else:
		is_wall_sliding = false
		
	
	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			wall_jumps_remaining = max_wall_jumps
			jump_sound.play()
			velocity.y = JUMP_VELOCITY
		elif is_wall_sliding and wall_jumps_remaining > 0:
			velocity.x = WALL_JUMP_VELOCITY.x * -last_wall_normal
			velocity.y = WALL_JUMP_VELOCITY.y
			wall_jumps_remaining -= 1
			is_wall_sliding = false
			jump_sound.play()

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
	$Animator.is_sliding = is_wall_sliding

	# Move and handle collisions
	move_and_slide()
