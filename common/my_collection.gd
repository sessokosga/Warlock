@tool
extends Control

@onready var hero_choice_container := $"%HeroChoiceContainer"
@onready var selected_card_name := $"%SelectedCardName"
@onready var selected_card_texture : TextureRect= $"%SelectedCardTexture"
@onready var btn_next : Button= $"%Next"
@onready var hero_choice : Control= $"%HeroChoice"
@onready var cards_choice : Control= $"%CardsChoice"

func filter_hero(item)->bool:
	return item.type == CardData.Warlock.Type.Hero

func _ready() -> void:
	for row  in CardData.table_warlock.all.filter(filter_hero):
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
	pass

func _process(_delta: float) -> void:
	# for card:Card in hero_choice_container.get_children():
	# 	if card.mode != Card.Mode.Field:
	# 		card.mode = Card.Mode.Field
			# print(card.title)
			# get_node( str(card.get_path()) + "/Name" ).text = card.title
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		for card :Card in hero_choice_container.get_children():
			var surf = Rect2(card.global_position,card.size)
			if surf.has_point(event.position):
				selected_card_name.text = card.title
				selected_card_texture.texture = card.get_profile_texture()
				btn_next.disabled = false
		


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://common/main.tscn")



func _on_next_pressed() -> void:
	hero_choice.hide()
	cards_choice.show()
	pass # Replace with function body.
