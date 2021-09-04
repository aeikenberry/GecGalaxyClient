extends Node

var player_id = null
var ships = 0
var star_id = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$Label.text = str(ships)
	$Player.text = str(player_id)
	
	if player_id == null:
		$Aura.visible = false
	else:
		$Aura.visible = true


func SetAuraColor(color):
	$Aura.color = color


func _on_Body_mouse_entered():
	print("Mouse entered") # Replace with function body.


func _on_Area2D_input_event(viewport, event, shape_idx):
	print(event) # Replace with function body.
