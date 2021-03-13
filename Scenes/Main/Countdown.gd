extends Node


func _ready():
	Events.connect("game_starting_in", self, "_game_starting_in")
	_hide_labels()


func _show_labels():
	get_node("StartinGameLabel").visible = true
	get_node("CountdownLabel").visible = true


func _hide_labels():
	get_node("StartinGameLabel").visible = false
	get_node("CountdownLabel").visible = false


func _game_starting_in(seconds):
	$CountdownLabel.text = str(seconds)
	_show_labels()
	
	if seconds == 0:
		yield(get_tree().create_timer(1.0), "timeout")
		_hide_labels()
