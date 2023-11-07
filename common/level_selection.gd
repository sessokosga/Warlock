extends Control

@onready var deck_choice : HBoxContainer = $"%DeckChoice"
@onready var deck_list : FlowContainer = $"%DeckList"
@onready var selected_deck_texture :TextureRect  = $"%SelectedDeckTexture"
@onready var lab_selected_deck_name : Label = $"%SelectedDeckName"
@onready var opponent_choise : HBoxContainer = $"%OpponentChoice"
@onready var btn_choose_deck :  = $"%ChooseD"

func _on_deck_pressed(deck:DeckNode):
	selected_deck_texture.texture = deck.get_profile()
	lab_selected_deck_name.text = deck.title
	btn_choose_deck.disabled = false

func load_decks()->void:
	var decks = Utilities.load_decks_instances_hero_only()
	for deck in decks:
		var deck_node = DeckNode.get_instance()
		deck_node.set_profile(deck.hero.get_profile_texture())
		deck_node.title = deck.title
		deck_node.id = deck.id
		deck_node.pressed.connect(_on_deck_pressed)
		deck_list.add_child(deck_node)

func _ready() -> void:
	deck_choice.show()
	opponent_choise.hide()
	load_decks()
	pass

func _on_back_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/main.tscn")



func _on_choose_d_pressed() -> void:
	opponent_choise.show()
	deck_choice.hide()
	pass # Replace with function body.


func _on_choose_opp_pressed() -> void:
	pass # Replace with function body.
