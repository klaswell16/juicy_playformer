extends Area2D
@onready var collect_sound = $CoinCollectSoundPlayer


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		# Play sound 
		if collect_sound:
			collect_sound.play()
			
			await collect_sound.finished
		
		PlatformerGameController.collect_coin()
		self.queue_free()
	pass # Replace with function body.
