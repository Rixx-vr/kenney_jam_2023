extends Node3D

class_name Scout

@export var speed: float = 5

var destination: Vector3

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
		


func set_destination(destination: Vector3):
	self.destination = destination
