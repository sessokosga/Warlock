extends Node

const FOLDER_NAME = "deck"

func card_type_string(id:int)->String:
	match id:
		CardData.Warlock.Type.Minion:
			return tr("Minion")
		CardData.Warlock.Type.Spell:
			return tr("Spell")
		CardData.Warlock.Type.Hero:
			return tr("Hero")
		_:
			return ""
			
func load_decks()->Dictionary:
	var result :Dictionary = {}
	var dir = DirAccess.open("user://%s" % FOLDER_NAME)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() == false:
				var path = "user://%s/%s" % [FOLDER_NAME,file_name]
				var file = FileAccess.open(path, FileAccess.READ)
				if file:
					var content = file.get_pascal_string()
					var dk = str_to_var(content)
					result[dk.id] = dk
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access %s ." % FOLDER_NAME)
	return result

