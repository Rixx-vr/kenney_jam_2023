extends Node2D
class_name GameUI

@onready var ship_internal: Node3D = $"../Ship"
@onready var world: Node3D = $"../World"

@onready var world_camera: Camera3D = $"../World/Camera"
@onready var ship_camera: Camera3D = $"../Ship/Camera"

@onready var ship_ui: Node2D = $"../Ship/ResearchUI"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ship_pressed():
	ship_internal.visible = true
	ship_camera.current = true
	world.visible = false
	ship_ui.visible = true


func _on_world_pressed():
	world.visible = true
	world_camera.current = true
	ship_internal.visible = false
	ship_ui.visible = false
