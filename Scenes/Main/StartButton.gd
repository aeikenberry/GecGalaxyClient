extends Button

func _init():
	visible = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_update", self, "_on_player_update")
	Events.connect("game_update", self, "_on_game_update")
	Events.connect("game_starting", self, "_on_game_starting")


func _on_player_update(players, host):
	if str(get_tree().get_network_unique_id()) == str(host):
		visible = true


func _on_game_update(game):
	visible = game.started == false


func _on_game_starting():
	visible = false
