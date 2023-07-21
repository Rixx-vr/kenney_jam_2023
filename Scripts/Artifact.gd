extends Node3D

class_name Artifact

@export var descriptions: Array[String] = ["", "", "", "", ""]
@export var dependencies: Array[Artifact] = [null, null, null, null, null]
@export var icon: Texture2D
@export var research_duration = 2

var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_progress() -> bool:
	return true


func is_researched() -> bool:
	return progress >= descriptions.size()


func get_requirement():
	return dependencies[min(progress, dependencies.size() -1 )]


func get_label() -> String:
	if progress == 0:
		return "???"
	else:
		return descriptions[min(progress, descriptions.size()) - 1]


func get_description() -> String:
	if progress == 0:
		return "???"
	else:
		return descriptions[min(progress, descriptions.size()) - 1]
