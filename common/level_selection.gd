extends Control

@onready var deck_choice : HBoxContainer = $"%DeckChoice"
@onready var deck_list : FlowContainer = $"%DeckList"
@onready var opp_list : FlowContainer = $"%OpponentList"
@onready var selected_deck_texture :TextureRect  = $"%SelectedDeckTexture"
@onready var selected_opp_texture :TextureRect  = $"%SelectedOppTexture"
@onready var lab_selected_deck_name : Label = $"%SelectedDeckName"
@onready var lab_selected_opp_name : Label = $"%SelectedOppName"
@onready var opponent_choise : HBoxContainer = $"%OpponentChoice"
@onready var btn_choose_deck :  = $"%ChooseD"
@onready var btn_choose_opp :  = $"%ChooseOpp"

enum ScreenState  {DeckChoice, OppChoice}
var curr_screen_state :ScreenState

func _on_deck_pressed(deck:DeckNode):
	selected_deck_texture.texture = deck.get_profile()
	lab_selected_deck_name.text = deck.title
	btn_choose_deck.disabled = false
	Utilities.set_hero_deck(deck.id)

func _on_opponent_pressed(deck:DeckNode):
	selected_opp_texture.texture = deck.get_profile()
	lab_selected_opp_name.text = deck.title
	btn_choose_opp.disabled = false
	Utilities.set_opponent_deck(deck.id)

func load_decks()->void:
	var decks = Utilities.load_decks_instances_hero_only()
	for deck in decks:
		var deck_node = DeckNode.get_instance()
		deck_node.set_profile(deck.hero.get_profile_texture())
		deck_node.title = deck.title
		deck_node.id = deck.id
		deck_node.pressed.connect(_on_deck_pressed)
		deck_list.add_child(deck_node)

func load_opp_decks()->void:
	var decks = Utilities.load_decks_instances_hero_only(true)
	for deck in decks:
		var deck_node = DeckNode.get_instance()
		deck_node.set_profile(deck.hero.get_profile_texture())
		deck_node.title = deck.title
		deck_node.id = deck.id
		deck_node.pressed.connect(_on_opponent_pressed)
		opp_list.add_child(deck_node)



func _ready() -> void:
	curr_screen_state = ScreenState.DeckChoice
	deck_choice.show()
	opponent_choise.hide()
	load_decks()
	load_opp_decks()
	curr_screen_state = ScreenState.DeckChoice
	pass

func _on_back_pressed() -> void:
	match curr_screen_state:
		ScreenState.DeckChoice:
			get_tree().change_scene_to_file("res://common/main.tscn")
		ScreenState.OppChoice:
			deck_choice.show()
			opponent_choise.hide()
			curr_screen_state = ScreenState.DeckChoice



func _on_choose_d_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	curr_screen_state = ScreenState.OppChoice
	opponent_choise.show()
	deck_choice.hide()


func _on_choose_opp_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/gameboard.tscn")
