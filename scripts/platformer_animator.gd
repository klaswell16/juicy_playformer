extends Node2D

var speed = 0
var on_ground = false
var is_sliding = false
var is_climbing = false  # ADD THIS
@export var animated_sprite : AnimatedSprite2D

func _process(delta: float) -> void:
	update_animation()

func update_animation():
	
	
	if is_climbing:
		# Ladder climbing 
		animated_sprite.play("climb")  
			
	elif is_sliding:
		
		animated_sprite.play("on_wall")
		
	elif on_ground:
		if speed > 0.2:
			animated_sprite.play("run")
		else:
			animated_sprite.play("default")
			
	else:
		animated_sprite.play("default") 
