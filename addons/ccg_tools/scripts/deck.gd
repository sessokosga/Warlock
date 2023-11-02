extends Control
class_name Deck

const MAX_DECK_SIZE = 20
static var deck_node = preload("res://addons/ccg_tools/scenes/deck.tscn")

var hero : Card
var title : String
var id :StringName
var cards:Array[Card]
var minions : Array[Card] :
	get:
		return cards.filter(is_a_minion)
		
var spells : Array[Card]:
	get:
		return cards.filter(is_a_spell)

func is_a_minion(card:Card):
	return card.type == CardData.Warlock.Type.keys()[CardData.Warlock.Type.Minion]
	
func is_a_spell(card:Card):
	return card.type == CardData.Warlock.Type.keys()[CardData.Warlock.Type.Spell]
	
static func get_instance():
	return deck_node.instantiate()

func add_card(card:Card):
	if cards.size()<MAX_DECK_SIZE:
		cards.append(card)

func remove_card(card:Card):
	for ca in cards:
		if ca.id == card.id:
			cards.remove_at(cards.find(ca))
			break
