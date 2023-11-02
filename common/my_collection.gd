extends Control

@onready var hero_choice_container := $"%HeroChoiceContainer"
@onready var selected_card_name := $"%SelectedCardName"
@onready var selected_card_texture : TextureRect= $"%SelectedCardTexture"
@onready var btn_next : Button= $"%Next"
@onready var hero_choice : Control= $"%HeroChoice"
@onready var cards_choice : Control= $"%CardsChoice"
@onready var cards_in_deck : Control= $"%CardsInDeck"
@onready var cards_list : Control= $"%CardsList"

func filter_hero(item)->bool:
	return item.type == CardData.Warlock.Type.Hero

func filter_minion(item)->bool:
	return item.type == CardData.Warlock.Type.Minion

func filter_spells(item)->bool:
	return item.type == CardData.Warlock.Type.Spell

func filter_but_hero(item)->bool:
	return item.type != CardData.Warlock.Type.Hero



func load_hero()->void:
	for row :CardData.Warlock.Row  in CardData.table_warlock.all.filter(filter_hero):
		var card = Card.get_instance()
		card.mode = Card.Mode.Field
		card.title = row.title
		card.id = row.id
		card.profile = row.profile
		card.hide_attack()
		card.hide_health()
		var label = Label.new()
		label.text = card.title
		label.position.y -= 20
		card.add_child(label)
		hero_choice_container.add_child(card)

func load_minions()->void:
	
	for row :CardData.Warlock.Row in CardData.table_warlock.all.filter(filter_minion):
		var card = Card.get_instance()
		card._scale = Vector2(.8,.8)
		card.mode = Card.Mode.Full
		card.title = row.title
		card.id = row.id
		card.profile = row.profile
		card.attack = row.attack
		card.mana = row.mana
		card.health = row.health
		card.decoration = row.decoration
		card.description = row.description
		card.back = row.back
		card.sample = row.sample
		card.type = Utilities.card_type_string(row.type)
		var label = Label.new()
		label.text = str("x",card.sample)
		label.position += Vector2(45,10)
		card.add_child(label)
		cards_list.add_child(card)

func load_spells()->void:
	for row :CardData.Warlock.Row  in CardData.table_warlock.all.filter(filter_spells):
		var card = Card.get_instance()
		card._scale = Vector2(.8,.8)
		card.mode = Card.Mode.Full
		card.title = row.title
		card.id = row.id
		card.profile = row.profile
		card.hide_attack()
		card.hide_health()
		card.attack = row.attack
		card.mana = row.mana
		card.health = row.health
		card.decoration = row.decoration
		card.description = row.description
		card.back = row.back
		card.sample = row.sample
		card.type = Utilities.card_type_string(row.type)
		var label = Label.new()
		label.text = str("x",card.sample)
		label.position += Vector2(45,10)
		card.add_child(label)
		cards_list.add_child(card)



func _ready() -> void:
	load_hero()
	load_minions()
	load_spells()
	pass

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		for card :Card in hero_choice_container.get_children():
			var surf = Rect2(card.global_position,card.size)
			if surf.has_point(event.position):
				selected_card_name.text = card.title
				selected_card_texture.texture = card.get_profile_texture()
				btn_next.disabled = false

		for card:Card in cards_list.get_children():
			var surf = Rect2(card.global_position,card.size)
			if surf.has_point(event.position):
				var lab = Label.new()
				lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
				lab.text = card.title
				cards_in_deck.add_child(lab)
		
		for lab:Label in cards_in_deck.get_children():
			var surf = Rect2(lab.global_position,lab.size)
			if surf.has_point(event.position):
				cards_in_deck.remove_child(lab)
				lab.queue_free()



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://common/main.tscn")



func _on_next_pressed() -> void:
	hero_choice.hide()
	cards_choice.show()
	pass # Replace with function body.
