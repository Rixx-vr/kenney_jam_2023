extends Camera3D

class_name ShipCamera

const RAY_LENGTH = 50
@onready var research: Research = $"../ResearchUI/TabContainer/Research"

func _get_selection(event):
	var state_space = get_world_3d().direct_space_state
	var from = project_ray_origin(event.position)
	var to = from + project_ray_normal(event.position) * RAY_LENGTH
	
	var raycast_querry = PhysicsRayQueryParameters3D.create(from, to)

	var result = state_space.intersect_ray(raycast_querry)
	
	if result != null and result.has("collider"):
		var collider:Node = result["collider"]
	
		if collider is StaticBody3D:
			var parent = collider.get_parent()

			if(parent is Artifact):
				research.load_artifact(parent)


func _input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				_get_selection(event)

# Updates mouselook and movement every frame
func _process(delta):
	pass
