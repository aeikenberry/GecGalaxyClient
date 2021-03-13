extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_registered", self, "_on_player_registered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player_registered(msg):
	self.visible = false


func _on_Button_pressed():
	print("HI!") # Replace with function body.
