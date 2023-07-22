class_name Camera extends Camera3D

const RAY_LENGTH = 1000

@onready var game: Game = $"../.."
@onready var scout: Scout = $"../craft_speederD"


@export_range(0.0, 1.0) var sensitivity: float = 0.25

const MOVE_SPEED = .10
const ZOOM_SPEED = 0.1
const ZOOM_MIN = 2.0
const ZOOM_MAX = 20.0

var _w = false
var _s = false
var _a = false
var _d = false
var _q = false
var _e = false
var _shift = false
var _alt = false

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0

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
				scout.pickup_artifact(parent)
				return

		scout.set_destination(result.position)


func _input(event):
	if not get_parent().visible:
		return

	if event is InputEventMouseMotion:
		_mouse_position = event.relative
	# Receives mouse motion
		# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_LEFT:
				_get_selection(event)
			MOUSE_BUTTON_WHEEL_UP: # Increases max velocity
				zoom_camera(.2)
			MOUSE_BUTTON_WHEEL_DOWN: # Decereases max velocity
				zoom_camera(-0.2)

	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				_w = event.pressed
			KEY_S:
				_s = event.pressed
			KEY_A:
				_a = event.pressed
			KEY_D:
				_d = event.pressed
			KEY_Q:
				_q = event.pressed
			KEY_E:
				_e = event.pressed
			KEY_SHIFT:
				_shift = event.pressed
			KEY_ALT:
				_alt = event.pressed
				
	_update_mouselook()


# Updates mouselook and movement every frame
func _process(delta):
	if not get_parent().visible:
		return
		

# Horizontal movement with WASD
	var move_vector = Vector3(
		(_d as float) - (_a as float), 
		0, #(_e as float) - (_q as float),
		(_s as float) - (_w as float)
	)

	move_vector = move_vector.normalized()
	move_camera(move_vector * MOVE_SPEED * (3 if _shift else 1))


func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_position *= sensitivity
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0, 0)
		
		# Prevents looking up/down too far
		pitch = clamp(pitch, -90 - _total_pitch, 90 - _total_pitch)
		_total_pitch += pitch
	
		rotate_y(deg_to_rad(-yaw))
		rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))


func zoom_camera(amount: float) -> void:
	translate(Vector3.FORWARD * amount)


func move_camera(movement: Vector3) -> void:
	# Make the movement relative to the camera's orientation
	var camera_basis = self.global_transform.basis
	
	#var global_movement: Vector3 = camera_basis.rotated(movement)
	var global_movement: Vector3 = movement
	global_movement *= camera_basis.get_rotation_quaternion().inverse()
	
	global_movement.y = 0

	global_translate(global_movement)
