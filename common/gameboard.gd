extends Control

@onready var player_table_top :HBoxContainer = $"%PlayerTabletop"
@onready var player_hero :HBoxContainer = $"%PlayerHero"
@onready var player_hand : Hand = $"%PlayerHand"
@onready var opp_table_top :HBoxContainer = $"%OppTabletop"
@onready var opp_hero :HBoxContainer = $"%OppHero"
@onready var opp_hand : Hand = $"%OppHand"

#@onready var  : = $"%"
var player_deck :Deck
var opp_deck :Deck


func _load_player()->void:
	var id = Utilities.get_hero_deck()
	player_deck = Utilities.load_deck_instance(id)
	player_hero.add_child(player_deck.hero)
	for i in range (6):
		var card := player_deck.cards[i]
		card._scale = Vector2(.7,.7)
		player_hand.add_child(card)
	for i in range (6):
		var card := player_deck.cards[6+i]
		card.mode = Card.Mode.Field
		player_table_top.add_child(card)
	
	
func _load_opponent()->void:
	var id = Utilities.get_opponent_deck()
	opp_deck = Utilities.load_deck_instance(id,true)
	opp_hero.add_child(opp_deck.hero)
	for i in range (6):
		var card := opp_deck.cards[i]
		card._scale = Vector2(.7,.7)
		opp_hand.add_child(card)
	for i in range (6):
		var card := opp_deck.cards[6+i]
		card.mode = Card.Mode.Field
		opp_table_top.add_child(card)

func _ready() -> void:
	#Utilities.load_test_data()
	_load_player()
	_load_opponent()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://common/level_selection.tscn")
