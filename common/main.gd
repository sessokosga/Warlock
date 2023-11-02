extends Control

var by_pass_menu = false
@onready var language_btn :Button = $"%Language Option"

func _ready() -> void:
	if by_pass_menu:
		_on_my_collection_pressed()
	if TranslationServer.get_locale() == "fr":
		language_btn.select(1)
	pass

func _on_language_option_item_selected(index:int) -> void:
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("fr")
		_:
			TranslationServer.set_locale("en")

	pass # Replace with function body.



func _on_my_collection_pressed() -> void:
	get_tree().change_scene_to_file("res://common/my_collection.tscn")
	pass # Replace with function body.

func _on_start_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.
