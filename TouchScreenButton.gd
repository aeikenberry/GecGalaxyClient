extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("HELLO!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TouchScreenButton_pressed():
	print("HI!")


func _on_TouchScreenButton_released():
	print("HELLO?") # Replace with function body.
