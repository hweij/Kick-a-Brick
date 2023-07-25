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
	const colors = [
		Color(0.5, 0.0, 0.5),
		Color(0.5, 0.5, 0.0),
		Color(0.0, 0.5, 0.5),
		Color(0.2, 0.0, 0.8)
	]
	var materials = [];
	for i in 4:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = colors[i]
		materials.push_back(mat)
	const num_rows = 6
	const num_cols = 20
	const w = 0.3
	const h = 0.1
	const offset_x = num_cols * w / 2
	const offset_y = h / 2
	var scene = load("res://rigid_brick.tscn")
	var boxes = []
	for row in num_rows:
		for col in num_cols:
			var box = scene.instantiate()
			#var mat = StandardMaterial3D.new()
			#var mat = box.get_node("Mesh").get_surface_override_material(0)
			#mat.albedo_color = Color(randf(), randf(), randf())
			box.get_node("Mesh").set_surface_override_material(0, materials[randi() % 4])
			box.transform.origin = Vector3(col * w - offset_x, row * h + offset_y, -2)
			self.add_child(box)
			boxes.push_back(box)

