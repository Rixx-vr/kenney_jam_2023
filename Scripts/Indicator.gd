extends TextureRect

class_name Indicator

@export var state: bool = false
@export var checked: Texture2D = preload("res://Assets/UI/dotRed.png")
@export var unchecked: Texture2D = preload("res://Assets/UI/dot_shadow.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_state(state: bool):
	self.state = state
	texture = checked if state else unchecked
