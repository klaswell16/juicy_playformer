extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find all ladders and connect their signals
	var ladders = get_tree().get_nodes_in_group("ladders")
	for ladder in ladders:
		ladder.player_entered_ladder.connect(_on_ladder_entered)
		ladder.player_exited_ladder.connect(_on_ladder_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
