extends Node2D

var started = false


func _ready():
	Events.connect("game_update", self, "_on_game_update")


func _on_join_button_pressed():
	var name = get_node("LineEdit").text
	Server.JoinGame(name)


func _on_StartButton_pressed():
	Server.StartGame("doon")


func _on_game_update(game):
	started = game.started
