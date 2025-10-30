extends Control

@export var parallax_strengths = [0.02, 0.04, 0.06]  

@onready var background_layers = [
	$BackgroundFar,
	$BackgroundMid, 
	$BackgroundClose
]
@onready var ui_container = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var screen_center = get_viewport().get_visible_rect().size / 2
	var base_offset = mouse_pos - screen_center
	
	# Add parallax to layers
	for i in range(background_layers.size()):
		var layer = background_layers[i]
		var strength = parallax_strengths[i]
		layer.position = base_offset * strength
	pass
