extends TabBar

class_name Research

@onready var timer: Timer = $Timer
@onready var timer_progress: ProgressBar = $Progress
@onready var name_label: Label = $Name
@onready var disc_label: RichTextLabel = $ColorRect2/Discription
@onready var research_progress: HBoxContainer = $ResearchProgress
@onready var ship: Node3D = $"../../.."
@onready var analyse_button: Button = $analyse
@onready var icon = $ColorRect/Image
@onready var game: Game = $"../../../.."

var artifact: Artifact = null
var identified = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(reseatch_ended)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped() and not artifact.is_researched():
		timer_progress.value = (timer.wait_time - timer.time_left) / timer.wait_time
		

func start_reseatch():
	var requirement = artifact.get_requirement()
	print(requirement)
	print(ship.has_in_bay(requirement))
	if timer.is_stopped() and requirement == null or ship.has_in_bay(requirement):
		timer.start(artifact.research_duration)
	
	
func reseatch_ended():
	timer.stop()
	timer_progress.value = 0
	artifact.progress += 1
	if artifact.is_researched():
		identified += 1
		game.update_tasks()
		artifact.disable()

	updat_artifact()


func get_identified():
	return identified


func _on_analyse_pressed():
	if artifact != null and timer.is_stopped():
		start_reseatch()


func load_artifact(artifact: Artifact):
	if timer.is_stopped():
		self.artifact = artifact
		updat_artifact()


func updat_artifact():
	if artifact != null:
		name_label.text = artifact.get_label()
		disc_label.text = artifact.get_description()
		for i in range(research_progress.get_child_count()):
			var prog: Indicator = research_progress.get_child(i)
			prog.set_state(artifact.progress > i)
		analyse_button.disabled = artifact.is_researched()
		if artifact.icon != null:
			icon.texture = artifact.icon
		else:
			icon.texture = null
	
