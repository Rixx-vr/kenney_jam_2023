extends Node3D

class_name Scout

@export var speed: float = 5

var destination: Vector3
var pickup_target: Artifact
@onready var game: Game = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	destination = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = destination - position
	
	destination *= Vector3(1,0,1)
	
	if distance.length() > 0.1:
		look_at(destination * Vector3(1,0,1))
		translate(Vector3.FORWARD * speed * delta)

	elif pickup_target != null:
			game.add_artifact(pickup_target)
			pickup_target = null


func pickup_artifact(artifact: Artifact):
	pickup_target = artifact
	destination = artifact.global_position

func set_destination(destination: Vector3):
	self.destination = destination
