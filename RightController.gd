extends XRController3D


var trigger_click = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#	pass

const RAY_LENGTH = 20

func _physics_process(_delta):
	var space_state = get_world_3d().direct_space_state

	var origin = self.global_position
	var dir := -self.global_transform.basis.z
	var end = origin + (dir * RAY_LENGTH)
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	# print(result)
	
	var push = false
	var state = get_input("trigger_click")
	if state != trigger_click:
		trigger_click = state
		push = trigger_click

	if push && result && result.collider:
		var obj = result.collider
		if obj is RigidBody3D:
			print("PUSH")
			print(result)
			var local_pos = result.position - obj.position
			print(local_pos)
			result.collider.apply_impulse(dir * 10, local_pos)
