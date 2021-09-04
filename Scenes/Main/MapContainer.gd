extends Container

var loaded = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_update", self, "_on_game_update")


func _on_game_update(game):
	if game.started and not loaded:
		loaded = true
		_loadem()


func _loadem():
	var m = preload("res://Scenes/Maps/MapBuilder.tscn").instance()
	add_child(m)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	if loaded:
		return
	
	_loadem()
	loaded = true
	
