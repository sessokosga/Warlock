extends Node

const FOLDER_NAME = "deck"
const OPP_DIR = "res://opp_decks"
var selected ={}

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
			
func load_decks(is_opponent=false)->Dictionary:
	var result :Dictionary = {}
	var dir
	if is_opponent == true:
		dir = DirAccess.open(OPP_DIR)
	else:
		dir = DirAccess.open("user://%s" % FOLDER_NAME)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() == false:
				var path
				if is_opponent == true:
					path = str(OPP_DIR,"/",file_name)
				else:
					path = "user://%s/%s" % [FOLDER_NAME,file_name]
				var file = FileAccess.open(path, FileAccess.READ)
				if file:
					var content = file.get_pascal_string()
					var dk = str_to_var(content)
					result[dk.id] = dk
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access %s ." % FOLDER_NAME)
	return result

func load_deck(id:String,is_opponent=false)->Dictionary:
	var result :Dictionary = {}
	var dir
	if is_opponent == true:
		dir = DirAccess.open("res://opp_decks")
	else:
		dir = DirAccess.open("user://%s" % FOLDER_NAME)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() == false:
				var path
				if is_opponent == true:
					path = str(OPP_DIR,"/",file_name)
				else:
					path = "user://%s/%s" % [FOLDER_NAME,file_name]
				var file = FileAccess.open(path, FileAccess.READ)
				if file:
					var content = file.get_pascal_string()
					var dk = str_to_var(content)
					if dk.id == id:
						return dk
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access %s ." % FOLDER_NAME)
	return result



func load_decks_instances_hero_only(is_opponent=false)->Array[Deck]:
	var result :Array[Deck] = []
	var d = load_decks(is_opponent)
	for id in d:
		var dk = d[id]
		var deck := Deck.get_instance()
		deck.id = dk.id
		deck.title = dk.title
		deck.hero = load_card(CardData.table_warlock.get_value(dk.hero))
		result.append(deck)
	return result

func load_deck_instance(id:String,is_opponent=false)->Deck:
	var dk = load_deck(id,is_opponent)
	var deck = Deck.get_instance()
	if dk.has("id"):
		deck.id = dk.id
		deck.title = dk.title
		deck.hero = load_card(CardData.table_warlock.get_value(dk.hero))
		deck.hero.mode = Card.Mode.Field
		for c_id in dk.cards:
			var row := CardData.table_warlock.get_value(c_id)
			deck.add_card(load_card(row))
	else :
		print(str("Deck ", id, " not found"))
	return deck

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
		card.effect = row.effect
	else:
		card.attack = row.attack
		card.health = row.health
		

	return card

func set_hero_deck(deck_id:StringName)->void:
	selected.hero_deck = deck_id

func get_hero_deck()->StringName:
	return selected.hero_deck

func set_opponent_deck(deck_id:StringName)->void:
	selected.opp_deck = deck_id

func get_opponent_deck()->StringName:
	return selected.opp_deck

func load_test_data()->void:
	set_hero_deck("deck_2409")
	set_opponent_deck("deck_2548")
	
