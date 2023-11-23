extends Control
class_name Deck

const MAX_DECK_SIZE = 20
static var deck_node = preload("res://addons/ccg_tools/scenes/deck.tscn")

var hero : Card
var title : String
var id :StringName
var _card_list:Array[Card]
var cards:Array[Card]:
	get:
		return _card_list.filter(is_valid)

var minions : Array[Card] :
	get:
		return _card_list.filter(is_a_minion)

var spells : Array[Card]:
	get:
		return _card_list.filter(is_a_spell)

func is_a_minion(card:Card):
	return card.type == CardData.Warlock.Type.Minion and card.is_removed_from_deck == false

func is_valid(card:Card):
	return card.is_removed_from_deck == false
	
func is_a_spell(card:Card):
	return card.type == CardData.Warlock.Type.Spell and card.is_removed_from_deck == false
	
static func get_instance()->Deck:
	return deck_node.instantiate()

func add_card(card:Card):
	if _card_list.size()<MAX_DECK_SIZE:
		_card_list.append(card)

func remove_card(card:Card):
	card.is_removed_from_deck = true
	"""for ca in _card_list:
		if ca.id == card.id:
			_card_list.remove_at(_card_list.find(ca))
			break"""
