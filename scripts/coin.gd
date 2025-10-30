extends Area2D
@onready var collect_sound = $CoinCollectSoundPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		# Play sound before freeing
		if collect_sound:
			collect_sound.play()
			# Wait for sound to finish playing before freeing (optional)
			await collect_sound.finished
		
		PlatformerGameController.collect_coin()
		self.queue_free()
	pass # Replace with function body.
