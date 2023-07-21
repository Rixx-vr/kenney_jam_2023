extends Node
class_name Game


var discoveries: Array[Artifact]

@onready var ship_internal: Ship = $Ship
@onready var world: Node3D = $World

@onready var ui: Node = $"Ship/ResearchUI"


# Called when the node enters the scene tree for the first time.
func _ready():
	ship_internal.visible = false
	world.visible = true
	ui.visible = false
	
	#var game = Game.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func add_artifact(artifact: Artifact):
	discoveries.append(artifact)
	ship_internal.add_to_bay(artifact)
	

