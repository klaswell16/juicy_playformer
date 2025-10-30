extends Area2D

@export var coins_needed = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if PlatformerGameController.coins_collected >= coins_needed:
		get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
	pass # Replace with function body.
