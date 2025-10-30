extends Area2D

signal player_entered_ladder
signal player_exited_ladder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered_ladder.emit()
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_exited_ladder.emit()
	pass # Replace with function body.
