extends Control

@onready var player : = $"%Player"
@onready var player_table_top : = $"%PlayerTabletop"
@onready var player_hero : = $"%PlayerHero"
@onready var player_hand :  = $"%PlayerHand"
@onready var opp : = $"%Opponent"
@onready var opp_table_top : = $"%OppTabletop"
@onready var opp_hero :HBoxContainer = $"%OppHero"
@onready var opp_hand : Hand = $"%OppHand"
@onready var ctlr_pause : = $"%Pause"
@onready var ctlr_victory : = $"%Victory"
@onready var ctlr_failure : = $"%Failure"
@onready var ctlr_surrender : = $"%Surrender"
@onready var hbc_buttons : = $"%Buttons"
@onready var ui : = $"%UI"
@onready var screen_size := Vector2(get_window().size.x,get_window().size.y)


#@onready var  : = $"%"
var player_deck :Deck
var opp_deck :Deck

enum GameState {Victory, Failure, Surrender, Playing, Paused}

var game_state : GameState:
	set(state):
		ui.hide()
		ctlr_victory.hide()
		ctlr_failure.hide()
		ctlr_pause.hide()
		hbc_buttons.hide()
		ctlr_surrender.hide()
		player.hide()
		opp.hide()
		match state:
			GameState.Victory:
				hbc_buttons.show()
				ctlr_victory.show()
			GameState.Failure:
				hbc_buttons.show()
				ctlr_failure.show()
			GameState.Surrender:
				hbc_buttons.show()
				ctlr_surrender.show()
			GameState.Playing:
				ui.show()
				player.show()
				opp.show()
			GameState.Paused:
				ctlr_pause.show()
			_:
				pass

		


func _load_player()->void:
	var id = Utilities.get_hero_deck()
	player_deck = Utilities.load_deck_instance(id)
	player_hero.add_child(player_deck.hero)
	for i in range (6):
		var card := player_deck.cards[i]
		card._scale = Vector2(.7,.7)
		card.initial_scale = card._scale
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
		card.initial_scale = card._scale
		card.show_back()
		opp_hand.add_child(card)
	for i in range (6):
		var card := opp_deck.cards[6+i]
		card.mode = Card.Mode.Field
		opp_table_top.add_child(card)

func _ready() -> void:
	Utilities.load_test_data()
	_load_player()
	_load_opponent()
	game_state = GameState.Playing

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		game_state = GameState.Paused

func kill_other_active_hovers(exception:Card):
	for card:Card in player_hand.get_children():
		if card != exception:
			if card.scale > card.initial_scale:
				card.play_animation(Card.Animations.ZoomOut)
				card.hover_state = Card.HoverState.Out

func handle_card_hover_in_hand():
	for card:Card in player_hand.get_children():
		var rect = Rect2(card.position+Vector2(44+40,30),Vector2(84,300))
		if card.rotation_state == Card.RotationState.Idle and card.moving_state == Card.MovingState.Idle \
			and card.hover_state == Card.HoverState.Out:
			if Rect2(Vector2.ZERO,screen_size).has_point(get_local_mouse_position()):
				if rect.has_point(get_local_mouse_position() - player_hand.position):
					if card.scale == card.initial_scale:
						card.play_animation(Card.Animations.ZoomIn)
						card.hover_state = Card.HoverState.Entered
						kill_other_active_hovers(card)
						

func handle_card_out_of_hover_in_hand():
	for card:Card in player_hand.get_children():
		var rect = Rect2(card.position,card.size+Vector2(0,70))
		if card.hover_state == Card.HoverState.Entered:
			if rect.has_point(get_local_mouse_position() - player_hand.position) == false:
				if card.scale > card.initial_scale:
					card.play_animation(Card.Animations.ZoomOut)
					card.hover_state = Card.HoverState.Out

func _physics_process(_delta: float) -> void:
	handle_card_hover_in_hand()
	handle_card_out_of_hover_in_hand()
	pass

func _on_back_pressed() -> void:

	get_tree().change_scene_to_file("res://common/level_selection.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://common/main.tscn")


func _on_resume_was_pressed() -> void:
	ctlr_pause.hide()
	ui.show()
	player.show()
	opp.show()
