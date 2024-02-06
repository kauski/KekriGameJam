extends Node3D

const RAY_LENGTH = 1000.0
var moveTarget
var body

var camera3d

var momentum = Vector3(0,0,0)

var lastPos

var isReleased = false

var openHand
var closedHand
var coffeeKuppi

var player
var winPlayer

var sceneChanger

func _ready():
	lastPos	 = Vector3(0,0,0)
	
	openHand = preload("res://Art/UI/UI_Cursor_open.png")
	closedHand = preload("res://Art/UI/UI_Cursor_closed.png")
	coffeeKuppi = preload("res://Art/UI/UI_Cursor_Coffeecup.png")
	
	player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = preload("res://Classical Relaxed main.wav")
	player.play()
	
	winPlayer = AudioStreamPlayer.new()
	add_child(winPlayer)
	winPlayer.stream = preload("res://Yippee.mp3")
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
#			get_tree().quit()
			_back_to_menu()
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		if get_tree().get_root().get_child(1).name == "Main":
			return
		Input.set_custom_mouse_cursor(closedHand,Input.CURSOR_ARROW,Vector2(32,32))
#		var camera = get_node("Camera") as Camera3D
#		var from = camera.project_ray_origin(event.position)
#		var to = from + camera.project_ray_normal(event.position) * RAY_LENGTH
#		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		if get_parent().get_child(1).get_node("Camera3D"):
			camera3d = get_parent().get_child(1).get_node("Camera3D")
#			camera3d = $"../DemoScene365/Camera3D" as Camera3D
			var from = camera3d.project_ray_origin(get_viewport().get_mouse_position())
			var to = from + camera3d.project_ray_normal(get_viewport().get_mouse_position()) * RAY_LENGTH
			var space = get_world_3d().direct_space_state
			var ray_query = PhysicsRayQueryParameters3D.new()
			ray_query.from = from
			ray_query.to = to
			ray_query.collide_with_areas = true
			var raycast_result = space.intersect_ray(ray_query)
			if raycast_result:
#				print(raycast_result.collider.name)
				if raycast_result.collider.is_in_group("Movable"):
					
					body = raycast_result.collider
					if body.name == "pannu":
						body.set_collision_mask_value(3, false)
					if body.is_in_group("Halko"):
						body.set_collision_mask_value(3, false)
					moveTarget = true
					body.axis_lock_angular_z = true
#					body.gravity_scale = 0
				if raycast_result.collider.is_in_group("Tree"):
					if randf() < 0.3:
#						print("puu")
						var hitObject = raycast_result.collider
						var hitParent = hitObject.get_parent_node_3d()
						hitObject.get_node("Puu")._spawn_leaf(hitObject.position)
					
					
						
	if event is InputEventMouseButton and event.is_released():
		if get_tree().get_root().get_child(1).name == "Main":
			return
		Input.set_custom_mouse_cursor(openHand,Input.CURSOR_ARROW,Vector2(32,32))
		if body:
			moveTarget = false
			body.axis_lock_angular_z = false
			if body.name == "pannu":
				body.set_collision_mask_value(3, true)
			if body.is_in_group("Halko"):
				body.set_collision_mask_value(3, true)
#			var vec = lastPos - global_position
#			body.linear_velocity = vec
#			print(vec)
			isReleased = true
#			body.gravity_scale = 1
#			body = null
func _physics_process(delta):

	if moveTarget && body:
		var mousePos = get_viewport().get_mouse_position()
		var dropPlane = Plane(Vector3(0,0,10), 0)
		var position3D = dropPlane.intersects_ray(camera3d.project_ray_origin(mousePos),camera3d.project_ray_normal(mousePos))
#		print(position3D)
#		var vectori = (body.position-position3D)
#		body.position = position3D
		momentum = position3D-body.position
		body.move_and_collide(momentum)
#		body.apply_force(vectori,Vector3(vectori.x,vectori.y, 0))
	if isReleased:
		var vec = lastPos - body.global_position
#		vec = vec.normalized()
#		print(vec)
#		vec *= 100
#		print(vec)
		body.linear_velocity = vec
		body = null
		isReleased = false
	if body:
		lastPos	= body.global_position

func _game_end():
	var transition = get_node("/root/Level1/Transitions")
	transition.scene_to_load = preload("res://Scenes/EndingScreen.tscn")
	body = null
	transition.changeScene()
#	get_tree().change_scene_to_file("res://Scenes/EndingScreen.tscn")
	await get_tree().create_timer(1.0).timeout
	winPlayer.play()

func _lose_screen():
	var transition = get_node("/root/Level1/Transitions")
	transition.scene_to_load = preload("res://Scenes/Losingscreen.tscn")
	transition.changeScene()
#	get_tree().change_scene_to_file("res://Scenes/Losingscreen.tscn")

func _back_to_menu():
	var change = get_tree().get_first_node_in_group("transition")
	change.scene_to_load = preload("res://Scenes/main.tscn")
	change.changeScene()
	await get_tree().create_timer(1.0).timeout
	Input.set_custom_mouse_cursor(coffeeKuppi,Input.CURSOR_ARROW,Vector2(32,32))



