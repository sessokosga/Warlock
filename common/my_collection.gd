extends Control

@onready var hero_choice_container :HBoxContainer= $"%HeroChoiceContainer"
@onready var lab_selected_hero_name :Label= $"%SelectedHeroName"
@onready var selected_hero_texture : TextureRect= $"%SelectedHeroTexture"
@onready var btn_next : Button= $"%Next"
@onready var hero_choice : Control= $"%HeroChoice"
@onready var cards_choice : Control= $"%CardsChoice"
@onready var home : Control= $"%Home"
@onready var cards_in_deck : Control= $"%CardsInDeck"
@onready var deck_list : Control= $"%DeckList"
@onready var cards_list : Control= $"%CardsList"
@onready var home_cards_list : Control= $"%HomeCardsList"
@onready var btn_done : Button= $"%Done"
@onready var btn_delete : Button= $"%Delete"
@onready var lab_cards_count : Label= $"%CardsCount"
@onready var le_deck_name : LineEdit= $"%DeckName"
@onready var lab_title : Label= $"%Title"
@onready var confirm_deck_delition : ConfirmationDialog= $"%ConfirmDeckDeletion"

const FOLDER_NAME = "deck"
var curr_random_id : int
var curr_deck=null
var screen_size

func filter_hero(item)->bool:
	return item.type == CardData.Warlock.Type.Hero

func filter_minion(item)->bool:
	return item.type == CardData.Warlock.Type.Minion

func filter_spells(item)->bool:
	return item.type == CardData.Warlock.Type.Spell

func filter_but_hero(item)->bool:
	return item.type != CardData.Warlock.Type.Hero

func clean_children(parent):
	for child in parent.get_children():
		child.queue_free()
		parent.remove_child(child)

func load_hero()->void:
	for row :CardData.Warlock.Row  in CardData.table_warlock.all.filter(filter_hero):
		var card = Utilities.load_card(row)
		card.mode = Card.Mode.Field
		var label = Label.new()
		label.text = card.title
		label.position.y -= 20
		card.add_child(label)
		hero_choice_container.add_child(card)

func add_sample_label(sample)->Label:
	var label = Label.new()
	label.text = str("x",sample)
	label.position += Vector2(45,10)
	return label

func add_my_label(id,text)->MyLabel:
	var lab = MyLabel.get_instance()
	lab.text = text
	lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lab.id = id
	return lab

func load_minions(parent,show_sample:bool=false)->void:
	
	for row :CardData.Warlock.Row in CardData.table_warlock.all.filter(filter_minion):
		var card = Utilities.load_card(row)
		card._scale = Vector2(.8,.8)
		card.mode = Card.Mode.Full
		if show_sample == true:
			var label = add_sample_label(card.sample)
			card.add_child(label)
		parent.add_child(card)
		

func load_spells(parent,show_sample:bool=false)->void:
	for row :CardData.Warlock.Row  in CardData.table_warlock.all.filter(filter_spells):
		var card = Utilities.load_card(row)
		card._scale = Vector2(.8,.8)
		card.mode = Card.Mode.Full
		if show_sample == true:
			var label = add_sample_label(card.sample)
			card.add_child(label)
		parent.add_child(card)

func load_cards_choice()->void:
	home.hide()
	cards_choice.show()
	load_minions(cards_list,true)
	load_spells(cards_list,true)
	le_deck_name.text = curr_deck.title
	btn_delete.disabled = false
	clean_children(cards_in_deck)
	for id in curr_deck.cards:
		var lab = add_my_label(id,id)
		cards_in_deck.add_child(lab)
		for card:Card in cards_list.get_children():
			if card.id == id:
				card.show_checkmark()
				card.sample-=1
				card.get_child(card.get_child_count()-1).text = str("x",card.sample)
				if card.sample <=0 :
					card.modulate = Color.DARK_GRAY
	
	update_cards_count()
	update_check_marks()
	validate_cards_number()

func load_home()->void:
	var decks = Utilities.load_decks()
	home.show()
	cards_choice.hide()
	hero_choice.hide()

	clean_children(deck_list)

	for id in decks:
		var btn = Button.new()
		btn.add_theme_font_size_override('font_size',20)
		var deck = decks[id]
		btn.name = id
		btn.text = deck.title
		for hero:Card in hero_choice_container.get_children():
			if hero.id == deck.hero:
				btn.icon = hero.get_profile_texture()
				btn.expand_icon = true
		btn.pressed.connect(
			func (): 
				AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
				curr_deck = deck
				load_cards_choice()
				)
		
		deck_list.add_child(btn)


func _ready() -> void:
	screen_size = get_window().size
	print(screen_size)
	load_hero()
	load_minions(home_cards_list)
	load_spells(home_cards_list)
	lab_cards_count.text = str(cards_in_deck.get_child_count(),"/",Deck.MAX_DECK_SIZE)
	randomize()
	load_home()
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
			if card.sample >= 1 and cards_in_deck.get_child_count() < Deck.MAX_DECK_SIZE:
				var surf = Rect2(card.global_position,card.size)
				if surf.has_point(event.position):
					var lab = add_my_label(card.id,card.title)
					cards_in_deck.add_child(lab)
					card.sample-=1
					card.get_child(card.get_child_count()-1).text = str("x",card.sample)
					if card.sample <=0 :
						card.modulate = Color.DARK_GRAY

		# Cancel cards selection
		for lab:Label in cards_in_deck.get_children():
			var surf := Rect2(lab.global_position,lab.size)
			var pos = lab.global_position.y+lab.size.y
			var pos2 =   lab.global_position.y
			if surf.has_point(event.position) and pos <= cards_in_deck.global_position.y+530 \
				and pos2 >= cards_in_deck.global_position.y:
				cards_in_deck.remove_child(lab)
				for card:Card in cards_list.get_children():
					if card.id == lab.id:
						card.sample+=1
						card.modulate = Color.WHITE
						card.get_child(card.get_child_count()-1).text = str("x",card.sample)
				lab.queue_free()
		update_cards_count()
		update_check_marks()
		validate_cards_number()

# Show checkmark on selected cards
func update_check_marks()->void:
	for lab:Label in cards_in_deck.get_children():
		for card:Card in cards_list.get_children():
			if card.id == lab.id:
				card.show_checkmark()

# Check if there is enought cards in the deck
func validate_cards_number()->void:
	if cards_in_deck.get_child_count() < Deck.MAX_DECK_SIZE:
		btn_done.disabled = true
	else:
		btn_done.disabled = false

# Update cards count
func update_cards_count()->void:
	lab_cards_count.text = str(cards_in_deck.get_child_count(),"/",Deck.MAX_DECK_SIZE)



func _on_back_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/main.tscn")



func _on_next_pressed() -> void:
	curr_random_id = randi() % 10_000
	var decks = Utilities.load_decks()
	while decks.has(str("deck_",curr_random_id)):
		curr_random_id = randi() % 10_000
	le_deck_name.text = str("Deck_",curr_random_id)
	hero_choice.hide()
	cards_choice.show()
	load_minions(cards_list,true)
	load_spells(cards_list,true)
	
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
		return true
	return false

func delete_deck(file_name:String)->bool:
	var path = "user://%s/%s.deck" % [FOLDER_NAME,file_name]
	DirAccess.remove_absolute(path)
	return false

func gen_cards_id_from_label(labels:Array[Node])->Array[String]:
	var result :Array[String]=[]
	for lab:Label in labels:
		result.append(lab.id)
	return result

func _on_done_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	var file_name 
	var hero_id 
	var title = le_deck_name.text
	var cards = gen_cards_id_from_label(cards_in_deck.get_children())
	if curr_deck == null :
		file_name = str("deck_",curr_random_id)
		hero_id = lab_selected_hero_name.name
	else:
		file_name = curr_deck.file_name
		hero_id = curr_deck.hero
		
	save_deck(file_name,title,hero_id,cards)
	load_home()
	btn_delete.disabled = true
	lab_title.text = name
	curr_deck = null
	reset_cards_sample()

func reset_cards_sample()->void:
	for card :Card in cards_list.get_children():
		card.sample = 4

func _on_new_deck_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	home.hide()
	hero_choice.show()
	cards_choice.hide()
	lab_title.text = "New Deck"
	clean_children(cards_in_deck)
	reset_cards_sample()
	
	pass # Replace with function body.



func _on_delete_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	if curr_deck != null:
		confirm_deck_delition.show()

func _on_confirm_deck_deletion_confirmed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	if curr_deck!= null:
		delete_deck(curr_deck.file_name)
		load_home()
