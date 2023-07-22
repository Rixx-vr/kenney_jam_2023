extends Node3D

class_name Artifact

enum ArtifactType {NONE, ORGAMIC, MECHANICAL, ELECTRONIC, CULTURAL}

@export var labels: Array[String] = ["", "", "", "", ""]
@export var descriptions: Array[String] = ["", "", "", "", ""]
@export var dependencies_path: Array[NodePath] = ["", "", "", "", ""]
var dependencies: Array[Artifact] = [null, null, null, null, null]
@export var icon: Texture2D
@export var research_duration = 2
@export var type: ArtifactType = ArtifactType.NONE

var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#this is just a workarount the editor refueses to set the Artifacts by Inspector
	for i in range(dependencies_path.size()):
			var node = get_node(dependencies_path[i])
			if node is Artifact:
				dependencies[i] = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_researched() -> bool:
	return progress >= labels.size()


func get_requirement():
	return dependencies[min(progress, dependencies.size() -1 )]


func get_label() -> String:
	if progress == 0:
		return "???"
	else:
		return labels[min(progress, labels.size()) - 1]


func get_description() -> String:
	var discription = ""

	if get_requirement() != null:
		discription += "\n\nWe think we can learn more about this Item if we have a look at the [b] %s [/b] first" % get_requirement().get_label()
	if progress == 0:
		return "???"
	else:
		return descriptions[min(progress, descriptions.size()) - 1] + discription
