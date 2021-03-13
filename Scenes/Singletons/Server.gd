extends Node2D

var network = NetworkedMultiplayerENet.new()
var ip = '127.0.0.1'
var port = 1909


func _ready():
	ConnectToServer()


func ConnectToServer():
	print("Connecting")
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")


func _on_connection_failed():
	print("Failed connection")


func _on_connection_succeeded():
	print("connected")
	Server.SayHi(self.get_instance_id())


func JoinGame(name):
	rpc_id(1, "Register", name)


func StartGame(map_name):
	rpc_id(1, "StartGame", map_name)


func SayHi(requestor):
	rpc_id(1, "SayHi", requestor)


remote func ReturnHi(msg, requestor):
	print("Server said: " + str(msg))


remote func RegisterSuccess(msg):
	Events.emit_signal("player_registered", msg)


remote func PlayerUpdate(players, host):
	Events.emit_signal("player_update", players, host)


remote func GameStartingIn(seconds):
	Events.emit_signal("game_starting_in", seconds)

remote func GameUpdate(game):
	Events.emit_signal("game_update", game)
	

remote func GameStarting(game, players):
	Events.emit_signal("game_starting")
