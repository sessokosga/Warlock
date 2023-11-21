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
@onready var targetting : = $"%Targetting"
@onready var screen_size := Vector2(get_window().size.x,get_window().size.y)



var player_deck :Deck
var opp_deck :Deck
var target := {
	from = Vector2.ZERO,
	to = Vector2.ZERO,
	victim=null,
	offender=null,
	is_active = false
}

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
		var card := opp_deck.spells[i]
		card._scale = Vector2(.7,.7)
		card.initial_scale = card._scale
		card.show_back()
		opp_hand.add_child(card)
	for i in range (6):
		var card := opp_deck.minions[i]
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

func show_card_details():
	# Player cards
	for card:Card in player_table_top.get_children():
		var rect = Rect2(card.position,card.size)
		if Rect2(Vector2.ZERO,screen_size).has_point(get_local_mouse_position()):
			var detail := card.get_full_size()
			if rect.has_point(get_local_mouse_position() - player_table_top.position) \
				and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				detail.show()
				detail.global_position = Vector2(0,130)
			else:
				detail.hide()
	
	# Opponent cards
	for card:Card in opp_table_top.get_children():
		var rect = Rect2(card.position,card.size)
		if Rect2(Vector2.ZERO,screen_size).has_point(get_local_mouse_position()):
			var detail := card.get_full_size()
			if rect.has_point(get_local_mouse_position() - opp_table_top.position) \
				and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				detail.show()
				detail.global_position = Vector2(0,130)
			else:
				detail.hide()
	
func draw_target():
	for card:Card in player_table_top.get_children():
		var rect = Rect2(card.position,card.size)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if Rect2(Vector2.ZERO,screen_size).has_point(get_local_mouse_position()):
				if rect.has_point(get_local_mouse_position() - player_table_top.position) \
					and target.is_active == false:
					target.is_active = true
					var pos = card.size/2 - Vector2(0,9)
					var image :=card.get_profile_texture().get_image()
					var ratio = card.size/Vector2( image.get_size())
					var color := image.get_pixel(pos.x/ratio.x,pos.y/ratio.y)

					target.from = card.global_position + pos
					target.offender = card
					targetting.modulate = color

	if target.is_active:
		target.to = get_local_mouse_position()
		var curve = Curve2D.new()
		curve.add_point(target.from)
		curve.add_point(target.to,Vector2(0,-140),Vector2(00,00))
		targetting.points = curve.get_baked_points()

func clear_target()->void:
	target.is_active = false
	targetting.clear_points()

func find_victim()->void:
	if target.is_active == false or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) \
		or Rect2(Vector2.ZERO,screen_size).has_point(get_local_mouse_position()) == false:
		return
	
	# Attack on opponent
	for card:Card in opp_table_top.get_children():
		var rect = Rect2(card.position,card.size)
		if rect.has_point(get_local_mouse_position() - opp_table_top.position):
			target.victim = card
	
	# clean the targetting if no victim is found
	if target.victim == null:
		clear_target()
	else:
		apply_damage()

func apply_damage()->void:
	if target.is_active == false:
		return
	var offender :Card = target.offender
	var victim :Card = target.victim
	offender.take_damage(victim.attack)
	victim.take_damage(offender.attack)
	clear_target()

func _physics_process(_delta: float) -> void:
	handle_card_hover_in_hand()
	handle_card_out_of_hover_in_hand()
	show_card_details()
	draw_target()
	find_victim()
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
