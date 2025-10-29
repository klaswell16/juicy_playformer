extends Node2D

var speed = 0
var on_ground = false
var is_sliding = false
@export var animated_sprite : AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_sliding:
		animated_sprite.play("on_wall")
		
	elif on_ground:
		if speed > 0.2:
			animated_sprite.play("run")
		else:
			animated_sprite.play("default")
	
	else:
		# You might want separate "jump" and "fall" animations later
		animated_sprite.play("default")  # or "jump" if you have it
