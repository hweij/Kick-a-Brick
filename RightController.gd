extends XRController3D

# Range of the ray
const RAY_LENGTH = 20

# Force for kicking bricks
const KICK_FORCE = 10

# Current trigger state, for trigger event detection
var trigger_click = false

# Called when the node enters the scene tree for the first time, not used for now.
func _ready():
	pass

# Called every display frame, not used for now.
func _process(_delta):
	pass

# We do things here since we are dealing with physics.
func _physics_process(_delta):
	# Ray tracing
	var space_state = get_world_3d().direct_space_state
	# Start of ray: the controller's position
	var origin := self.global_position
	# Direction of the ray, pointing forward
	var dir := -self.global_transform.basis.z
	# End of the ray
	var end := origin + (dir * RAY_LENGTH)
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	var result := space_state.intersect_ray(query)
	
	# Trigger detection
	var kick = false
	var tc := self.get_float("trigger_click") as bool
	if tc != trigger_click:
		trigger_click = tc
		kick = trigger_click

	# Kicking bricks
	if kick && result:
		var obj = result.collider
		if obj is RigidBody3D:
			var hit_pos = result.position - obj.position
			result.collider.apply_impulse(dir * KICK_FORCE, hit_pos)
