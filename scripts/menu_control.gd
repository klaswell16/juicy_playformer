extends Control

@onready var start_button = $StartButton
@onready var quit_button = $QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	animate_title()
	pass # Replace with function body.






func _on_start_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/p_level_1.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
	
func animate_title():
	var title = $Title
	if title:
		var tween = create_tween()
		tween.tween_property(title, "scale", Vector2(1.1, 1.1), 2)
		tween.tween_property(title, "scale", Vector2(1.0, 1.0), 2)
		tween.set_loops()
