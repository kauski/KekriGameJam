extends RigidBody3D

signal HeatPercentChanged(newAmount)
signal BrewPercentChanged(newAmount)
signal CoffeeLeftChanged(newAmount)

@export var HeatPurcent : float = 0.0
@export var BrrrewPurcent : float = 0.0
@export var CoffeeLeftPurcent: float = 0.0
@export var ThermodynamicalSpeed : float = 0.3
@export var HeatLossPerTick : float = 0.15
@export var BrrrewUpPerTick : float = 0.1
@export var MaxDistanceToFire : float = 3

@onready var blackSmoke : GPUParticles3D = $BlackSmoke


func CountBurningContacts():
	var counter : int = 0
	for i in get_tree().get_nodes_in_group("Halko"):
		i = i as Halko
		if i == null:
			continue
		if i.Burning == false:
			continue
		var distance = i.global_position.distance_to(self.global_position)
		if distance < MaxDistanceToFire:
			counter += 1
	return counter


func Tick():
	
	ThermoDynamicSimulation()
	if HeatPurcent < 80:
		blackSmoke.visible = false
		BrrrewPurcent -= BrrrewUpPerTick
	elif HeatPurcent < 110:
		blackSmoke.visible = false
		BrrrewPurcent += BrrrewUpPerTick
	else:
		blackSmoke.visible = true
		BrrrewPurcent -= BrrrewUpPerTick * 5
		
	# Clamp all values
	HeatPurcent = clampf(HeatPurcent, 0, 120)
	BrrrewPurcent = clampf(BrrrewPurcent, 0, 100)
	
	BrewPercentChanged.emit(BrrrewPurcent)
	HeatPercentChanged.emit(HeatPurcent)
	

func ThermoDynamicSimulation():
	HeatPurcent -= HeatLossPerTick
	if HeatPurcent < 0:
		HeatPurcent = 0
	
	var HeatLevel = CountBurningContacts()
	
	var FireTemperature = HeatLevel * 40
	# Proposal 1
	#HeatPurcent += ((FireTemperature - HeatPurcent) / 20.0) * ThermodynamicalSpeed
	
	# Proposal 2
	if (FireTemperature - HeatPurcent) / 100.0 * ThermodynamicalSpeed > 0:
		HeatPurcent += (FireTemperature - HeatPurcent) / 100.0 * ThermodynamicalSpeed
