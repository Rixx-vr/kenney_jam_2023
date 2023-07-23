extends Button

class_name Skill

@export var scanner_type: Artifact.ArtifactType = Artifact.ArtifactType.ORGAMIC
@export var range: float = 10
@export var cooldown: float = 10
@onready var game: Game = $"../../.."

var timer: Timer
@onready var label: Label = $"Label"

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(on_button_pressed)
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_timeout)
	timer.one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped():
		label.text = "%2.1f" % timer.time_left

func on_button_pressed():
	game.cancell_ship()
	if timer.is_stopped():
		game.unveil_artifacts(self)
		timer.start(cooldown)
		disabled = true

func _timeout():
	disabled = false
	label.text = ""
