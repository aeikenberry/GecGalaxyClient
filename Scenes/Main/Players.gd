extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _players = {}
var _host


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_update", self, "_on_player_update")
	Events.connect("game_update", self, "_on_game_update")


func _on_game_update(game):
	_set_labels(game.players, game.host)


func _set_labels(players, host):
	if players.keys() == _players.keys() and str(host) == str(_host):
		return
	
	for child in $PlayerCardContainer.get_children():
		$PlayerCardContainer.remove_child(child)
		child.queue_free()
		
	for player_id in players.keys():
		var player = players[player_id]
		var fullName = player.name
		var s = preload("res://Scenes/Main/PlayerCard.tscn").instance()
		
		if str(player_id) == str(host):
			fullName = name + " *"
		
		s.get_node("PlayerName").text = fullName
		s.rect_min_size = Vector2(150, 50)
		$PlayerCardContainer.add_child(s)
	
	_players = players
	_host = host


func _on_player_update(players, host):
	print(players)
	print(host)
	_set_labels(players, host)

