extends Control

@onready var hero_choice_container :HBoxContainer= $"%HeroChoiceContainer"
@onready var lab_selected_hero_name :Label= $"%SelectedHeroName"
@onready var selected_hero_texture : TextureRect= $"%SelectedHeroTexture"
@onready var btn_next : Button= $"%Next"
@onready var hero_choice : Control= $"%HeroChoice"
@onready var cards_choice : Control= $"%CardsChoice"
@onready var home : Control= $"%Home"
@onready var cards_in_deck : Control= $"%CardsInDeck"
@onready var cards_list : Control= $"%CardsList"
@onready var home_cards_list : Control= $"%HomeCardsList"
@onready var btn_done : Button= $"%Done"
@onready var lab_cards_count : Label= $"%CardsCount"
@onready var le_deck_name : LineEdit= $"%DeckName"
@onready var lab_title : Label= $"%Title"

const FOLDER_NAME = "decks"
var curr_random_id : int

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

func load_minions(parent)->void:
	
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
		parent.add_child(card)
		

func load_spells(parent)->void:
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
		parent.add_child(card)



func _ready() -> void:
	load_hero()
	load_minions(home_cards_list)
	load_spells(home_cards_list)
	lab_cards_count.text = str(cards_in_deck.get_child_count(),"/",Deck.MAX_DECK_SIZE)
	randomize()
	pass

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		# Select hero
		for card :Card in hero_choice_container.get_children():
			var surf = Rect2(card.global_position,card.size)
			if surf.has_point(event.position):
				lab_selected_hero_name.text = card.title
				lab_selected_hero_name.name = card.id
				selected_hero_texture.texture = card.get_profile_texture()
				btn_next.disabled = false

		# Select cards
		for card:Card in cards_list.get_children():
			card.hide_checkmark()
			if card.sample >= 1:
				var surf = Rect2(card.global_position,card.size)
				if surf.has_point(event.position):
					var lab = MyLabel.get_instance()
					lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					lab.text = card.title
					lab.id = card.id
					cards_in_deck.add_child(lab)
					card.sample-=1
					card.get_child(card.get_child_count()-1).text = str("x",card.sample)
					if card.sample <=0 :
						card.modulate = Color.DARK_GRAY

		# Cancel cards selection
		for lab:Label in cards_in_deck.get_children():
			var surf = Rect2(lab.global_position,lab.size)
			if surf.has_point(event.position):
				cards_in_deck.remove_child(lab)
				for card:Card in cards_list.get_children():
					if card.title == lab.text:
						card.sample+=1
						card.modulate = Color.WHITE
						card.get_child(card.get_child_count()-1).text = str("x",card.sample)
				lab.queue_free()

		# Show checkmark on selected cards
		for lab:Label in cards_in_deck.get_children():
			for card:Card in cards_list.get_children():
				if card.title == lab.text:
					card.show_checkmark()
		
		# Check if there is enought cards in the deck
		if cards_in_deck.get_child_count() < 4:
		# if cards_in_deck.get_child_count() < Deck.MAX_DECK_SIZE:
			btn_done.disabled = true
		else:
			btn_done.disabled = false

		# Update cards count
		lab_cards_count.text = str(cards_in_deck.get_child_count(),"/",Deck.MAX_DECK_SIZE)
		
			



func _on_back_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/main.tscn")



func _on_next_pressed() -> void:
	curr_random_id = randi() % 10_000
	le_deck_name.text = str("Deck_",curr_random_id)
	hero_choice.hide()
	cards_choice.show()
	load_minions(cards_list)
	load_spells(cards_list)
	
	pass # Replace with function body.

func save_deck(file_name:String,deck_title:String,hero_id:String,cards:Array[String])->bool:
	#create the deck folder if it doesn't exist
	if DirAccess.dir_exists_absolute("user://%s" % FOLDER_NAME) == false:
		var dir = DirAccess.open("user://")
		dir.make_dir(FOLDER_NAME)
		DirAccess.make_dir_absolute("user://%s" % FOLDER_NAME)
	#Save to the file
	var path = "user://%s/%s.deck" % [FOLDER_NAME,file_name]
	var save = FileAccess.open(path,FileAccess.WRITE)
	if save:
		var data = {
			file_name = file_name,
			title = deck_title,
			hero = hero_id,
			cards = cards,
			id = file_name
		}
		save.store_pascal_string(var_to_str(data))
		print("deck %s saved" % data.title)
		print(data)
		return true
	return false

func gen_cards_id_from_label(labels:Array[Node])->Array[String]:
	var result :Array[String]=[]
	for lab:Label in labels:
		result.append(lab.id)
	return result

func _on_done_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)

	var file_name = str("deck_",curr_random_id)
	var title = le_deck_name.text
	var hero_id = lab_selected_hero_name.name
	var cards = gen_cards_id_from_label(cards_in_deck.get_children())
	save_deck(file_name,title,hero_id,cards)
	cards_choice.hide()
	home.show()
	lab_title.text = name
	pass # Replace with function body.


func _on_new_deck_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	home.hide()
	hero_choice.show()
	cards_choice.hide()
	lab_title.text = "New Deck"
	pass # Replace with function body.
