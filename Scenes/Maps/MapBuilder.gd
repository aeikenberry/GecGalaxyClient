extends Node2D

var maps = {
	"doon": "res://Assets/MapData/doon.json",
	"DOON": "res://Assets/MapData/doon.json",
}

var auras = [
	Color(1, 1, 1, .3),
	Color(.6, .6, .3, .3),
	Color(.4, .2, .3, .3),
]

var stars_by_id = {}
var drawn_connections = []


# Called when the node enters the scene tree for the first time.
func _ready():
	load_map("doon")
	Events.connect("game_update", self, "_on_game_update")


func load_map(map_name):
	var map_json = load_map_json(maps[map_name])
	build_map(map_json)


func build_map(map_data):
	for star in map_data["stars"]:
		build_star(star)
	for star in map_data["stars"]:
		build_lines(star, stars_by_id[star["id"]])
	

func build_lines(star_data, star_node):
	var connections = star_data["connections"]
	var my_id = star_data["id"]
	var line_offset = 0
	
	for star_id in connections:
		var connection_key = str(my_id) + "_" + str(star_id)
		
		var other_key = str(star_id) + "_" + str(my_id)
		if drawn_connections.find(other_key) > -1:
			continue
		
		drawn_connections.append(connection_key)
		var other_star_node = stars_by_id[star_id]
		var line = preload("res://Scenes/Stars/Line.tscn").instance()
		line.add_point(Vector2(star_node.position.x + line_offset, star_node.position.y + line_offset))
		line.add_point(Vector2(other_star_node.position.x + line_offset, other_star_node.position.y + line_offset))
		$Lines.add_child(line)
				
		
func build_star(star_data):
	match star_data["class"]:
		"Star":
			return _build_normal_star(star_data)
		_:
			return _build_normal_star(star_data)


func _build_normal_star(star_data):
	var star = preload("res://Scenes/Stars/Star.tscn").instance()
	star.position.x = star_data["x"]
	star.position.y = star_data["y"]
	star.ships = star_data["ships"]
	star.player_id = star_data["player"]
	star.star_id = star_data["id"]
	stars_by_id[star_data["id"]] = star
	$Stars.add_child(star)
	
	return star


func load_map_json(asset_path):
	var file = File.new()
	file.open(asset_path, File.READ)
	var map_text = file.get_as_text()
	file.close()
	
	return JSON.parse(map_text).result
	

func _on_game_update(game):
	var player_ids = game["players"].keys()
	for star in game["map"]["stars"]:
		var star_node = stars_by_id[star.id]
		star_node.ships = star.ships
		star_node.player_id = star.player
		star_node.SetAuraColor(auras[player_ids.find(star.player)])

