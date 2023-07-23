class_name Ship

extends Node3D

@onready var loot: Node3D = $Loot

@export var grid: Vector2i = Vector2i(10, 5)
@export var space: float = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_to_bay(artifact : Artifact):
	var place = loot.get_child_count()
	
	var x = place % grid.x
	var y = int(place / grid.y)
	artifact.get_parent().remove_child(artifact)
	loot.add_child(artifact)
	artifact.position = Vector3(x * space, 0, y * space)


func has_in_bay(artifact : Artifact):
	for child in loot.get_children():
		if child == artifact:
			return child.is_researched()
			
	return false
	
