extends Control

@onready var BrewPercentBar : TextureProgressBar = $BrewBar/BrewBar
@onready var HeatPercentBar : TextureProgressBar = $HeatBar/HeatBar
@onready var CoffeeLeftPercentBar : TextureProgressBar = $CoffeeBar/CoffeeBar

var handOpen = preload("res://Art/UI/UI_Cursor_open.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(handOpen,Input.CURSOR_ARROW,Vector2(32,32))

func ChangeBrewPercent(newAmount):
	BrewPercentBar.value = newAmount
	if BrewPercentBar.value >= 100:
		Manager._game_end()

func ChangeHeatPercent(newAmount):
	HeatPercentBar.value = newAmount
	
func ChangeCoffeeLeftPercent(newAmount):
	CoffeeLeftPercentBar.value = newAmount

