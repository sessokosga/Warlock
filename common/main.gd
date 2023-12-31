extends Control

@export var by_pass_menu = false
@onready var language_btn :Button = $"%Language Option"

func _ready() -> void:
	if by_pass_menu:
		get_tree().change_scene_to_file("res://common/gameboard.tscn")
	if TranslationServer.get_locale() == "fr":
		language_btn.select(1)
	pass 
	
func _on_language_option_item_selected(index:int) -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("fr")
		_:
			TranslationServer.set_locale("en")

	pass # Replace with function body.



func _on_my_collection_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/my_collection.tscn")
	pass # Replace with function body.

func _on_start_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/level_selection.tscn")
	


func _on_credits_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/credits.tscn")
	pass # Replace with function body.


func _on_leaderboard_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	pass # Replace with function body.
