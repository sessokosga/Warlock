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

func load_decks_instances_hero_only()->Array[Deck]:
	var result :Array[Deck] = []
	var d = load_decks()
	for id in d:
		var dk = d[id]
		var deck := Deck.get_instance()
		deck.id = dk.id
		deck.title = dk.title
		deck.hero = load_card(CardData.table_warlock.get_value(dk.hero))
		result.append(deck)
	return result

func load_card(row:CardData.Warlock.Row)->Card:
	var card = Card.get_instance()
	card.title = row.title
	card.id = row.id
	card.profile = row.profile
	card.mana = row.mana
	card.decoration = row.decoration
	card.description = row.description
	card.back = row.back
	card.sample = row.sample
	card.type = row.type
	if row.type != CardData.Warlock.Type.Minion:
		card.hide_attack()
		card.hide_health()
	else:
		card.attack = row.attack
		card.health = row.health

	return card