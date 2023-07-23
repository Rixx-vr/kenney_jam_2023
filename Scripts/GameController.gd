extends Node
class_name Game


var discoveries: Array[Artifact]

@onready var ship_internal: Ship = $Ship
@onready var world: Node3D = $World
@onready var scout: Scout = $World/craft_speederD
@onready var research: Research = $Ship/ResearchUI/TabContainer/Research

@onready var ui: Node = $"Ship/ResearchUI"
@onready var hud: Node = $Node2D

@onready var world_artifacts: Node = $World/Artifacts
@onready var game_over: TabContainer = $Node2D/GameOver

var artifact_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ship_internal.visible = false
	world.visible = true
	ui.visible = false
	
	for child in world_artifacts.get_children():
		if child is Artifact:
			child.visible = child.type == Artifact.ArtifactType.NONE
			artifact_count += 1
	update_tasks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_tasks():
	var itentified = research.get_identified()
	hud.update_tasks(artifact_count - world_artifacts.get_child_count(),
		artifact_count,
		itentified)

	if artifact_count == itentified:
		game_over.visible = true


func add_artifact(artifact: Artifact):
	discoveries.append(artifact)
	ship_internal.add_to_bay(artifact)
	update_tasks()


func cancell_ship():
	scout.cancell_target()


func unveil_artifacts(skill: Skill):
	for child in world_artifacts.get_children():
		if child is Artifact:
			var artifact: Artifact = child
			var distance = ((artifact.global_position - scout.global_position) * Vector3(1,0,1)).length()
			if artifact.type == skill.scanner_type and distance < skill.range:
				artifact.visible = true



func _on_close_pressed():
	game_over.visible = false
