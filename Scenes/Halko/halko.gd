class_name Halko
extends RigidBody3D


signal HalkoLighted
signal HalkoBurntThrough

@export var SpreadDistance : float = 0.8
@export var Burning : bool = false
@export var BurnTimeMinSec : float = 20
@export var BurnTimeMaxSec : float = 40
@onready var mesh : MeshInstance3D
@onready var FireVFX : Node3D = $FireVFX
@export var IsHalko = false
@export var InfiniteFlame : bool = false


var BurnTimeSec: float = 3
var NextTickAtMs : int = 0
var TimeSpentBurning : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if IsHalko:
		mesh = $Flammable/RootNode/Log_001
	
	BurnTimeSec = randf_range(BurnTimeMinSec, BurnTimeMaxSec)
	FireVFX.visible = false
	if Burning:
		Burn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Burning == false:
		return
	if IsHalko:
		ShaderMagic()
	
	TimeSpentBurning += delta
	if TimeSpentBurning > BurnTimeSec && InfiniteFlame == false:
		#HalkoLighted.emit() # No
		HalkoBurntThrough.emit() # Yes
		self.queue_free()
		if Manager.body == self:
			Manager.body = null


func SpreadFire():
	if Burning == false:
		return
	for i in get_tree().get_nodes_in_group("Halko"):
		i = i as Halko
		if i == null:
			continue
		var distance = i.global_position.distance_to(self.global_position)
		if distance < SpreadDistance:
			i.Burn()


func ShaderMagic():
	if TimeSpentBurning == 0:
		return
	if mesh == null:
		return
	if mesh.is_queued_for_deletion():
		return
	var mat = mesh.get_surface_override_material(0) as ShaderMaterial
	# I dont know why it gets null instances sometimes and this is fine, right?
	# But this should fix it
	if mat == null:
		return
	var x = TimeSpentBurning / BurnTimeSec
	x = x * x * x * x
	mat.set_shader_parameter("Burned", x)

	
	
func Burn():
	HalkoLighted.emit()
	Burning = true
	# Enable VFX
	FireVFX.visible = true
	$Timer.wait_time = randf_range(5,7)
	$Timer.autostart = true
	$Timer.start()


func _on_timer_timeout():
	SpreadFire()
