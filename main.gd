extends Node3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
	create_wall()
	
func _process(_delta):
	pass

func create_wall():
	# Wall dimensions
	const num_rows = 9
	const num_cols = 20
	# Brick size (should match size of bricks defined in rigid_brick scene
	const w = 0.3
	const h = 0.1
	# Brick colors
	const colors = [
		Color(0.5, 0.0, 0.5),
		Color(0.5, 0.5, 0.0),
		Color(0.0, 0.5, 0.5),
		Color(0.2, 0.0, 0.8)
	]
	# Brick materials from colors
	var materials = colors.map(
		func (c):
			var mat = StandardMaterial3D.new()
			mat.albedo_color = c
			return mat
	)
	var num_materials := materials.size()
	var scene = load("res://rigid_brick.tscn")
	var boxes = []
	const offset_y = h / 2
	for row in num_rows:
		# Even rows have 1 more brick than uneven rows.
		# To create a stable wall, make sure the number of rows is uneven
		var n = num_cols if (row % 2) else (num_cols - 1)
		var offset_x := (n as float) * w / 2.0
		for col in n:
			var box = scene.instantiate()
			box.get_node("Mesh").set_surface_override_material(0, materials[randi_range(0, num_materials - 1)])
			box.transform.origin = Vector3(col * w - offset_x, row * h + offset_y, -2)
			self.add_child(box)
			boxes.push_back(box)
