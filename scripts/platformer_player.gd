extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0  
const CLIMB_SPEED = 100.0

var is_on_ladder = false
var is_climbing = false
var was_climbing = false

@onready var jump_sound = $JumpSound
@onready var climb_sound = $ClimbSound

const WALL_JUMP_VELOCITY = Vector2(400, -450)  
const WALL_SLIDE_SPEED = 100.0  
var max_wall_jumps = 1
var wall_jumps_remaining = 0
var is_wall_sliding = false
var last_wall_normal = 0

func _ready() -> void:
	
	var ladders = get_tree().get_nodes_in_group("ladders")
	for ladder in ladders:
		ladder.player_entered_ladder.connect(_on_ladder_entered)
		ladder.player_exited_ladder.connect(_on_ladder_exited)
		
func _physics_process(delta: float) -> void:
	
	handle_ladder_movement(delta)
	
	if not is_on_floor() and not is_climbing:
		velocity.y += GRAVITY * delta
	
	# Reset wall jumps to 1 
	if is_on_floor():
		wall_jumps_remaining = max_wall_jumps
		is_wall_sliding = false
	
	# Sliding on wall
	if is_on_wall() and not is_on_floor() and not is_climbing and velocity.y > 0:
		is_wall_sliding = true
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED)
		last_wall_normal = get_wall_normal().x
	else:
		is_wall_sliding = false
	
	# Jump when not on ladder
	if Input.is_action_just_pressed("jump") and not is_climbing:
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

	# Horizontal movement, gets stoppped when on ladder
	var direction := Input.get_axis("left", "right")
	if direction and not is_climbing:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	handle_climbing_sound()
	update_animations()
	move_and_slide()

func handle_ladder_movement(delta):
	if is_on_ladder:
		var vertical_direction = Input.get_axis("up", "down")
		
		if vertical_direction != 0:
			# Start climbing
			is_climbing = true
			velocity.y = vertical_direction * CLIMB_SPEED
		elif is_climbing:
			# Stop climbing but still on the ladder
			velocity.y = 0
	else:
		# Not on ladder
		is_climbing = false
		
func handle_climbing_sound():
	if is_climbing and abs(velocity.y) > 0:
		
		if not climb_sound.playing:
			climb_sound.play()
	else:
		# Stopped moving
		if climb_sound.playing:
			climb_sound.stop()

	
	
	was_climbing = is_climbing

func update_animations():
	if is_climbing:
		$AnimatedSprite2D.play("climb")
	elif velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	$Animator.speed = abs(velocity.x)
	$Animator.on_ground = is_on_floor()
	$Animator.is_sliding = is_wall_sliding
	$Animator.is_climbing = is_climbing  


func _on_ladder_entered():
	is_on_ladder = true

func _on_ladder_exited():
	is_on_ladder = false
	is_climbing = false
	climb_sound.stop()
