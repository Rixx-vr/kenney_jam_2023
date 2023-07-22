extends Node
class_name Game


var discoveries: Array[Artifact]

@onready var ship_internal: Ship = $Ship
@onready var world: Node3D = $World
@onready var scout: Scout = $World/craft_speederD

@onready var ui: Node = $"Ship/ResearchUI"

@onready var world_artifacts: Node = $World/Artifacts


# Called when the node enters the scene tree for the first time.
func _ready():
	ship_internal.visible = false
	world.visible = true
	ui.visible = false
	
	for child in world_artifacts.get_children():
		if child is Artifact:
			child.visible = child.type == Artifact.ArtifactType.NONE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func add_artifact(artifact: Artifact):
	discoveries.append(artifact)
	ship_internal.add_to_bay(artifact)


func unveil_artifacts(skill: Skill):
	for child in world_artifacts.get_children():
		if child is Artifact:
			var artifact: Artifact = child
			var distance = ((artifact.global_position - scout.global_position) * Vector3(1,0,1)).length()
			print(distance)
			print(artifact.type)
			print(skill.scanner_type)
			print(artifact.type == skill.scanner_type)
			print(distance < skill.range)
			if artifact.type == skill.scanner_type and distance < skill.range:
				artifact.visible = true

