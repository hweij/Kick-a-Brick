extends Node3D

var xr_interface: XRInterface

var leftController: XRController3D
var rightController: XRController3D

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

	# Store references to the controllers, might remove this later
	leftController = get_node("Player/XROrigin3D/LeftController");
	rightController = get_node("Player/XROrigin3D/LeftController");
	
	create_wall()
	
func _process(_delta):
	pass
	# print(leftController.get_input("trigger_click"))

func create_wall():
	var scene = load("res://rigid_box.tscn")
	for row in 3:
		for col in 7:
			var box = scene.instantiate()
			self.add_child(box)
			box.transform.origin = Vector3(col - 3, row + 0.5, -2)
