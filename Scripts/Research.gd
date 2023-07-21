extends TabBar

class_name Research

@onready var timer: Timer = $Timer
@onready var timer_progress: ProgressBar = $Progress
@onready var name_label: Label = $Name
@onready var research_progress: HBoxContainer = $ResearchProgress
@onready var ship: Node3D = $"../../.."
@onready var analyse_button: Button = $analyse
@onready var icon = $ColorRect/Image

var artifact: Artifact = null

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(reseatch_ended)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped() and not artifact.is_researched():
		timer_progress.value = (timer.wait_time - timer.time_left) / timer.wait_time
		

func start_reseatch():
	if timer.is_stopped():
		timer.start(artifact.research_duration)
	
	
func reseatch_ended():
	timer.stop()
	timer_progress.value = 0
	artifact.progress += 1
	updat_artifact()


func _on_analyse_pressed():
	if artifact != null:
		start_reseatch()
	
	
func load_artifact(artifact: Artifact):
	var requirement = artifact.get_requirement()
	
	if timer.is_stopped() and requirement == null or ship.has_in_bay(requirement):
		self.artifact = artifact
		updat_artifact()


func updat_artifact():
	if artifact != null:
		name_label.text = artifact.get_label()
		for i in range(research_progress.get_child_count()):
			var prog: Indicator = research_progress.get_child(i)
			prog.set_state(artifact.progress > i)
		analyse_button.disabled = artifact.is_researched()
		if artifact.icon != null:
			icon.texture = artifact.icon
		else:
			icon.texture = null
	
