extends Node

const LEVEL_DATA_PATH: String = "res://data/level_data.json"
const TILE_SIZE: int = 32


var _level_data: Dictionary = {} # level: LevelLayout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level_data()
	pass

func setup_level(lns: String, raw_level_data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	
	var ps = raw_level_data.player_start
	layout.set_player_start(ps.x, ps.y)
	
	return layout

func load_level_data() -> void:
	var file = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	var raw_data = JSON.parse_string(file.get_as_text())

	for lns in raw_data.keys():
		var new_level_layout: LevelLayout = setup_level(lns, raw_data[lns])
#		print("new_level_layout:%s %d,%d" % [
#			new_level_layout.get_instance_id(),
#			new_level_layout.get_player_start().x,
#			new_level_layout.get_player_start().y
#		])
		_level_data[lns] = new_level_layout
