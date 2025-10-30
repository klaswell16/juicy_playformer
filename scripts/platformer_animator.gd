extends Node2D

var speed = 0
var on_ground = false
var is_sliding = false
var is_climbing = false  # ADD THIS
@export var animated_sprite : AnimatedSprite2D

func _process(delta: float) -> void:
	update_animation()

func update_animation():
	# Priority order: climbing > wall sliding > air > ground movements
	
	if is_climbing:
		# Handle ladder climbing animations
		animated_sprite.play("climb")  # or just "climb" if you don't have separate idle
			
	elif is_sliding:
		# Wall sliding has highest priority after climbing
		animated_sprite.play("on_wall")
		
	elif on_ground:
		# Ground movements (running/idle)
		if speed > 0.2:
			animated_sprite.play("run")
		else:
			animated_sprite.play("default")
			
	else:
		# Air movements (jumping/falling)
		# You might want to add separate "jump" and "fall" animations later
		animated_sprite.play("default")  # or "default" if you don't have jump animation
