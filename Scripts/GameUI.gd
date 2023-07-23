extends Node2D
class_name GameUI

@onready var ship_internal: Node3D = $"../Ship"
@onready var world: Node3D = $"../World"
@onready var game: Node3D = $".."

@onready var world_camera: Camera3D = $"../World/Camera"
@onready var ship_camera: Camera3D = $"../Ship/Camera"

@onready var ship_ui: Node2D = $"../Ship/ResearchUI"
@onready var skills: HBoxContainer = $Skills
@onready var tasks: Label = $Tasks


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ship_pressed():
	game.cancell_ship()
	ship_internal.visible = true
	ship_camera.current = true
	world.visible = false
	ship_ui.visible = true
	skills.visible = false


func _on_world_pressed():
	game.cancell_ship()
	world.visible = true
	world_camera.current = true
	ship_internal.visible = false
	ship_ui.visible = false
	skills.visible = true


func update_tasks(found, total, identified):
	var format = "Tasks:\nArtifacts found: {found}/{total}\nArtifacts identified: {identified}/{total}"
	tasks.text = format.format({"found": found, "total": total, "identified": identified})
