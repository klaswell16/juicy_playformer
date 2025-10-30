extends Area2D

@export_multiline var message = "Collect 4 gold coins to open the portal!"

@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	
	pass # Replace with function body.



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("talking")
		label.text = message
		label.visible = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("default")
		label.visible = false
	pass # Replace with function body.
